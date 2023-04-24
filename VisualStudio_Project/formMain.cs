using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Windows.Forms;
using System.IO;
using System.Diagnostics;

namespace cod2_sp_ulg_launcher
{
    public partial class formMain : Form
    {
        static string path = Directory.GetCurrentDirectory();
        //we set our path constant and then do .ini/.dll cleanup/setup
        public formMain()
        {
            InitializeComponent();
            //folder cleanup
            initClean();
            //file setup
            initSetup();

            //some ui changes
            this.tableLayoutFlags.BackColor = Color.Transparent;

            this.buttonUSSR.FlatAppearance.MouseOverBackColor = Color.FromArgb(30, 255, 255, 255);
            this.buttonUSSR.FlatAppearance.MouseDownBackColor = Color.FromArgb(30, 255, 255, 255);
            this.buttonUK.FlatAppearance.MouseOverBackColor = Color.FromArgb(30, 255, 255, 255);
            this.buttonUK.FlatAppearance.MouseDownBackColor = Color.FromArgb(30, 255, 255, 255);
            this.buttonUSA.FlatAppearance.MouseOverBackColor = Color.FromArgb(30, 255, 255, 255);
            this.buttonUSA.FlatAppearance.MouseDownBackColor = Color.FromArgb(30, 255, 255, 255);
        }
        private void button_MouseEnter(object sender, EventArgs e)
        {
            var btn = (Button)sender;
            btn.ForeColor = SystemColors.ControlLightLight;
        }
        private void button_MouseLeave(object sender, EventArgs e)
        {
            var btn = (Button)sender;
            btn.ForeColor = Color.LemonChiffon;
        }
        private void buttonMissionSelect_Click(object sender, EventArgs e)
        {
            mainPanel.Visible = false;
            missionSelectPanel.Visible = true;
            mainPanel.SendToBack();
            missionSelectPanel.BringToFront();
        }
        private void buttonQuit_Click(object sender, EventArgs e)
        {
            this.Close();
        }
        private void buttonOptions_Click(object sender, EventArgs e)
        {
            mainPanel.Visible = false;
            optionsPanel.Visible = true;
            mainPanel.SendToBack();
            optionsPanel.BringToFront();
        }
        private void comboBoxRenderMain_SelectedIndexChanged(object sender, EventArgs e)
        {
            //if index is changed by user choice or on program start, we update renderer and perform file ops
            string selection = (string)comboBoxRenderMain.SelectedItem;
            int index = comboBoxRenderMain.FindStringExact(selection);
            string renderType = "hw";
            initClean(); //make sure we're working with a clean slate
            switch (index)
            {
                case 1:
                    renderType = "wine";
                    rendererWINE();
                    break;
                case 2:
                    renderType = "sw30";
                    rendererSW30();
                    break;
                case 3:
                    renderType = "sw32";
                    rendererSW32();
                    break;
                default:
                    renderType = "hw";
                    initClean();
                    break;
            }
            string toWrite = iniBuilder(renderType);
            File.WriteAllText((path + "/cod2_sp_ulg.ini"), toWrite);
        }

        private String iniBuilder(String renderType)
        {
            String toReturn ="";
            toReturn += "renderer=" + renderType;
            toReturn += "\n::\n" +
                "Renderer Types:\n" +
                "sw30 is software swiftshader 3.0 by MegaFox\n" +
                "sw32 is software swiftshader 3.2 by rboxeur\n" +
                "hw is hardware d3d9\n" + 
                "wine is hardware wined3d\n::";
            return toReturn;
        }
        private void initClean()
        {
            fileDelete("d3d9.dll");
            fileDelete("wined3d.dll");
            fileDelete("libwine.dll");
            //don't forget these, these can break swiftshader
            fileDelete("sw-pixel.dir");
            fileDelete("sw-setup.dir");
            fileDelete("sw-vertex.dir");
            fileDelete("sw-pixel.dll");
            fileDelete("sw-setup.dll");
            fileDelete("sw-vertex.dll");
        }
        private void initSetup()
        {
            string[] iniLines;
            string renderer = "hw";
            try {
                iniLines = System.IO.File.ReadAllLines(path + "\\cod2_sp_ulg.ini");
                string[] renderSetting = iniLines[0].Split('=');
                renderer = renderSetting[1]; //update renderer with ini file setting, if possible
                Console.WriteLine(renderer);
            } catch (IOException ioExp) {
                Console.WriteLine(ioExp.Message);
            }
            switch (renderer) //file operations should be called as this should trigger an onIndexChanged event
            {
                case "wine":
                    comboBoxRenderMain.SelectedIndex = comboBoxRenderMain.FindStringExact("HW OpenGL (wineD3D)");
                    break;
                case "sw30":
                    comboBoxRenderMain.SelectedIndex = comboBoxRenderMain.FindStringExact("SW (Swiftshader 3.0)");
                    break;
                case "sw32":
                    comboBoxRenderMain.SelectedIndex = comboBoxRenderMain.FindStringExact("SW (Swiftshader 3.2)");
                    break;
                default:
                    comboBoxRenderMain.SelectedIndex = comboBoxRenderMain.FindStringExact("HW D3D9 (Default)");
                    break;
            }
        }
        private void rendererSW30()
        {
            try
            {
                File.Copy(Path.Combine(path + "\\cod2_sp_ulg_dlls", "d3d9.sw3.0.dll"), Path.Combine(path, "d3d9.dll"), true);
            } catch (IOException ioExp)
            {
                Console.WriteLine(ioExp.Message);
            }
        }
        private void rendererSW32()
        {
            try
            {
                File.Copy(Path.Combine(path + "\\cod2_sp_ulg_dlls", "d3d9.sw3.2.dll"), Path.Combine(path, "d3d9.dll"), true);
            }
            catch (IOException ioExp)
            {
                Console.WriteLine(ioExp.Message);
            }
        }
        private void rendererWINE()
        {
            try
            {
                File.Copy(Path.Combine(path + "\\cod2_sp_ulg_dlls", "d3d9.wine.17.28.dll"), Path.Combine(path, "d3d9.dll"), true);
                File.Copy(Path.Combine(path + "\\cod2_sp_ulg_dlls", "libwine.dll"), Path.Combine(path, "libwine.dll"), true);
                File.Copy(Path.Combine(path + "\\cod2_sp_ulg_dlls", "wined3d.dll"), Path.Combine(path, "wined3d.dll"), true);
            }
            catch (IOException ioExp)
            {
                Console.WriteLine(ioExp.Message);
            }
        }
        private void fileDelete(String arg)
        {
            try {
                // Check if file exists with its full path    
                if (File.Exists(Path.Combine(path, arg)))
                {
                    // If file found, delete it    
                    File.Delete(Path.Combine(path, arg));
                    Console.WriteLine("File " + arg + " deleted.");
                }
                else Console.WriteLine("File " + arg + " not found");
            }
            catch (IOException ioExp) {
                Console.WriteLine(ioExp.Message);
            }
        }

        // --BUTTON HANDLERS-- //

        //CAMPAIGN SELECT BUTTONS
        private void buttonMSBack_Click(object sender, EventArgs e)
        {
            mainPanel.Visible = true;
            missionSelectPanel.Visible = false;
            missionSelectPanel.SendToBack();
            mainPanel.BringToFront();
        }

        private void buttonUK_Click(object sender, EventArgs e)
        {
            tableLayoutMissionsUK.Visible = true;
            tableLayoutMissionsUSSR.Visible = false;
            tableLayoutMissionsUSA.Visible = false;
            tableLayoutMissionsUSSR.SendToBack();
            tableLayoutMissionsUSA.SendToBack();
            tableLayoutMissionsUK.BringToFront();
        }

        private void buttonUSSR_Click(object sender, EventArgs e)
        {
            tableLayoutMissionsUSSR.Visible = true;
            tableLayoutMissionsUK.Visible = false;
            tableLayoutMissionsUSA.Visible = false;
            tableLayoutMissionsUK.SendToBack();
            tableLayoutMissionsUSA.SendToBack();
            tableLayoutMissionsUSSR.BringToFront();
        }

        private void buttonUSA_Click(object sender, EventArgs e)
        {
            tableLayoutMissionsUSA.Visible = true;
            tableLayoutMissionsUK.Visible = false;
            tableLayoutMissionsUSSR.Visible = false;
            tableLayoutMissionsUK.SendToBack();
            tableLayoutMissionsUSSR.SendToBack();
            tableLayoutMissionsUSA.BringToFront();
        }

        //MISSION SELECT BUTTONS USSR
        private void c1m1Button_Click(object sender, EventArgs e)
        {
            Process p = new Process();
            p.StartInfo.FileName = path + "\\CoD2SP_s.exe";
            p.StartInfo.Arguments = "+set \"com_introplayed 1\" +spdevmap \"moscow\" +exec \"autoexec.cfg\"";
            p.Start();
        }
        private void c1m2Button_Click(object sender, EventArgs e)
        {
            Process p = new Process();
            p.StartInfo.FileName = path + "\\CoD2SP_s.exe";
            p.StartInfo.Arguments = "+set \"com_introplayed 1\" +spdevmap \"demolition\" +exec \"autoexec.cfg\"";
            p.Start();
        }

        private void c2m1Button_Click(object sender, EventArgs e)
        {
            Process p = new Process();
            p.StartInfo.FileName = path + "\\CoD2SP_s.exe";
            p.StartInfo.Arguments = "+set \"com_introplayed 1\" +spdevmap \"tankhunt\" +exec \"autoexec.cfg\"";
            p.Start();
        }

        private void c2m2Button_Click(object sender, EventArgs e)
        {
            Process p = new Process();
            p.StartInfo.FileName = path + "\\CoD2SP_s.exe";
            p.StartInfo.Arguments = "+set \"com_introplayed 1\" +spdevmap \"trainyard\" +exec \"autoexec.cfg\"";
            p.Start();
        }

        private void c3m1Button_Click(object sender, EventArgs e)
        {
            Process p = new Process();
            p.StartInfo.FileName = path + "\\CoD2SP_s.exe";
            p.StartInfo.Arguments = "+set \"com_introplayed 1\" +spdevmap \"downtown_assault\" +exec \"autoexec.cfg\"";
            p.Start();
        }

        private void c3m2Button_Click(object sender, EventArgs e)
        {
            Process p = new Process();
            p.StartInfo.FileName = path + "\\CoD2SP_s.exe";
            p.StartInfo.Arguments = "+set \"com_introplayed 1\" +spdevmap \"cityhall\" +exec \"autoexec.cfg\"";
            p.Start();
        }

        private void c3m3Button_Click(object sender, EventArgs e)
        {
            Process p = new Process();
            p.StartInfo.FileName = path + "\\CoD2SP_s.exe";
            p.StartInfo.Arguments = "+set \"com_introplayed 1\" +spdevmap \"downtown_sniper\" +exec \"autoexec.cfg\"";
            p.Start();
        }

        private void c4m1Button_Click(object sender, EventArgs e)
        {
            Process p = new Process();
            p.StartInfo.FileName = path + "\\CoD2SP_s.exe";
            p.StartInfo.Arguments = "+set \"com_introplayed 1\" +spdevmap \"decoytrenches\" +exec \"autoexec.cfg\"";
            p.Start();
        }

        private void c4m2Button_Click(object sender, EventArgs e)
        {
            Process p = new Process();
            p.StartInfo.FileName = path + "\\CoD2SP_s.exe";
            p.StartInfo.Arguments = "+set \"com_introplayed 1\" +spdevmap \"decoytown\" +exec \"autoexec.cfg\"";
            p.Start();
        }

        private void c4m3Button_Click(object sender, EventArgs e)
        {
            Process p = new Process();
            p.StartInfo.FileName = path + "\\CoD2SP_s.exe";
            p.StartInfo.Arguments = "+set \"com_introplayed 1\" +spdevmap \"elalamein\" +exec \"autoexec.cfg\"";
            p.Start();
        }

        private void c4m4Button_Click(object sender, EventArgs e)
        {
            Process p = new Process();
            p.StartInfo.FileName = path + "\\CoD2SP_s.exe";
            p.StartInfo.Arguments = "+set \"com_introplayed 1\" +spdevmap \"eldaba\" +exec \"autoexec.cfg\"";
            p.Start();
        }

        private void c5m1Button_Click(object sender, EventArgs e)
        {
            Process p = new Process();
            p.StartInfo.FileName = path + "\\CoD2SP_s.exe";
            p.StartInfo.Arguments = "+set \"com_introplayed 1\" +spdevmap \"libya\" +exec \"autoexec.cfg\"";
            p.Start();
        }

        private void c5m2Button_Click(object sender, EventArgs e)
        {
            Process p = new Process();
            p.StartInfo.FileName = path + "\\CoD2SP_s.exe";
            p.StartInfo.Arguments = "+set \"com_introplayed 1\" +spdevmap \"88ridge\" +exec \"autoexec.cfg\"";
            p.Start();
        }

        private void c6m1Button_Click(object sender, EventArgs e)
        {
            Process p = new Process();
            p.StartInfo.FileName = path + "\\CoD2SP_s.exe";
            p.StartInfo.Arguments = "+set \"com_introplayed 1\" +spdevmap \"toujane_ride\" +exec \"autoexec.cfg\"";
            p.Start();
        }

        private void c6m2Button_Click(object sender, EventArgs e)
        {
            Process p = new Process();
            p.StartInfo.FileName = path + "\\CoD2SP_s.exe";
            p.StartInfo.Arguments = "+set \"com_introplayed 1\" +spdevmap \"toujane\" +exec \"autoexec.cfg\"";
            p.Start();
        }

        private void c6m3Button_Click(object sender, EventArgs e)
        {
            Process p = new Process();
            p.StartInfo.FileName = path + "\\CoD2SP_s.exe";
            p.StartInfo.Arguments = "+set \"com_introplayed 1\" +spdevmap \"matmata\" +exec \"autoexec.cfg\"";
            p.Start();
        }

        private void c7m1Button_Click(object sender, EventArgs e)
        {
            Process p = new Process();
            p.StartInfo.FileName = path + "\\CoD2SP_s.exe";
            p.StartInfo.Arguments = "+set \"com_introplayed 1\" +spdevmap \"beltot\" +exec \"autoexec.cfg\"";
            p.Start();
        }

        private void c7m2Button_Click(object sender, EventArgs e)
        {
            Process p = new Process();
            p.StartInfo.FileName = path + "\\CoD2SP_s.exe";
            p.StartInfo.Arguments = "+set \"com_introplayed 1\" +spdevmap \"crossroads\" +exec \"autoexec.cfg\"";
            p.Start();
        }

        private void c7m3Button_Click(object sender, EventArgs e)
        {
            Process p = new Process();
            p.StartInfo.FileName = path + "\\CoD2SP_s.exe";
            p.StartInfo.Arguments = "+set \"com_introplayed 1\" +spdevmap \"newvillers\" +exec \"autoexec.cfg\"";
            p.Start();
        }

        private void c7m4Button_Click(object sender, EventArgs e)
        {
            Process p = new Process();
            p.StartInfo.FileName = path + "\\CoD2SP_s.exe";
            p.StartInfo.Arguments = "+set \"com_introplayed 1\" +spdevmap \"breakout\" +exec \"autoexec.cfg\"";
            p.Start();
        }

        private void c8m1Button_Click(object sender, EventArgs e)
        {
            Process p = new Process();
            p.StartInfo.FileName = path + "\\CoD2SP_s.exe";
            p.StartInfo.Arguments = "+set \"com_introplayed 1\" +spdevmap \"duhoc_assault\" +exec \"autoexec.cfg\"";
            p.Start();
        }

        private void c8m2Button_Click(object sender, EventArgs e)
        {
            Process p = new Process();
            p.StartInfo.FileName = path + "\\CoD2SP_s.exe";
            p.StartInfo.Arguments = "+set \"com_introplayed 1\" +spdevmap \"duhoc_defend\" +exec \"autoexec.cfg\"";
            p.Start();
        }

        private void c8m3Button_Click(object sender, EventArgs e)
        {
            Process p = new Process();
            p.StartInfo.FileName = path + "\\CoD2SP_s.exe";
            p.StartInfo.Arguments = "+set \"com_introplayed 1\" +spdevmap \"silotown_assault\" +exec \"autoexec.cfg\"";
            p.Start();
        }

        private void c9m1Button_Click(object sender, EventArgs e)
        {
            Process p = new Process();
            p.StartInfo.FileName = path + "\\CoD2SP_s.exe";
            p.StartInfo.Arguments = "+set \"com_introplayed 1\" +spdevmap \"bergstein\" +exec \"autoexec.cfg\"";
            p.Start();
        }

        private void c9m2Button_Click(object sender, EventArgs e)
        {
            Process p = new Process();
            p.StartInfo.FileName = path + "\\CoD2SP_s.exe";
            p.StartInfo.Arguments = "+set \"com_introplayed 1\" +spdevmap \"hill400_assault\" +exec \"autoexec.cfg\"";
            p.Start();
        }

        private void c9m3Button_Click(object sender, EventArgs e)
        {
            Process p = new Process();
            p.StartInfo.FileName = path + "\\CoD2SP_s.exe";
            p.StartInfo.Arguments = "+set \"com_introplayed 1\" +spdevmap \"hill400_defend\" +exec \"autoexec.cfg\"";
            p.Start();
        }

        private void c10m1Button_Click(object sender, EventArgs e)
        {
            Process p = new Process();
            p.StartInfo.FileName = path + "\\CoD2SP_s.exe";
            p.StartInfo.Arguments = "+set \"com_introplayed 1\" +spdevmap \"rhine\" +exec \"autoexec.cfg\"";
            p.Start();
        }
        private void Form1_Load(object sender, EventArgs e)
        {
            //unused method
        }
    }
}
