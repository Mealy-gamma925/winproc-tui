# 📊 winproc-tui - Track windows system performance with ease

[![](https://img.shields.io/badge/Download-Latest_Release-blue.svg)](https://github.com/Mealy-gamma925/winproc-tui/releases)

Winproc-tui offers a clear way to see how your computer runs internal processes. You gain insight into memory usage, processor load, and background tasks. This tool provides live updates so you spot performance spikes as they happen.

## 🛠️ System Requirements

Your computer must run Windows 11. The software requires 64-bit architecture. You need at least 4GB of memory to track metrics. Ensure your user account holds administrator rights. Certain metrics require these permissions to gather data from system processes.

## 📥 How to Install

1. Visit the [releases page](https://github.com/Mealy-gamma925/winproc-tui/releases) to download the software.
2. Look for the file ending in `.exe`. 
3. Select the file to start the download.
4. Save the file to a folder you locate easily.
5. Double-click the file to open the program.
6. A black window appears with your process list.

## 🚀 Getting Started

When you launch winproc-tui, the screen displays a list of active programs. Each line shows the process name and current resource usage. The software updates every second. 

You navigate the list using the arrow keys on your keyboard. Press the up arrow to highlight a task and the down arrow to move lower. The program highlights the selected item in a different color to show your current focus.

## 📈 Understanding the Metrics

The main view shows three primary columns. 

*   **CPU:** This shows how much work your processor handles for each task. High values indicate heavy load.
*   **Memory:** This column tracks how much RAM a program consumes. 
*   **Disk:** This track shows how much data the program reads from or writes to your hard drive. 

Watch these numbers over time to identify what slows down your system. 

## ⚖️ Comparing Processes

Use the A/B comparison feature to contrast two tasks.
1. Highlight the first process using the arrow keys.
2. Press the `A` key to lock in your first choice.
3. Move to the second process.
4. Press the `B` key to lock in your second choice.
5. The screen splits to show both metrics side by side.
6. Press the `Esc` key to return to the main list.

This feature helps you decide which application consumes more resources when both run at the same time.

## 💾 Recording Data

You capture performance history to review later. 
1. Press the `R` key to start recording.
2. A red dot appears in the corner of the screen.
3. Perform the actions you want to measure on your computer. 
4. Press `R` again to stop the recording. 
5. The program saves a text file in the same folder as the application. 
6. Open this file with any text editor to read the historical data.

The recorded data logs the CPU and memory spikes during the capture window. This helps you identify patterns in performance issues.

## 🖥️ Live Graphs

The TUI generates time-series graphs for selected processes. When you select a process, the bottom half of the screen displays a line chart. The chart moves from left to right as time passes. Green lines represent CPU activity, while blue lines represent memory usage. Watch the line height to see how your system handles stress. 

## ❓ Troubleshooting

If the program fails to open, check your Windows version. Ensure you have the latest updates from Microsoft. Some antivirus programs block new software. If this occurs, tell your antivirus to allow winproc-tui to run. The program does not connect to the internet, so it poses no risk to your private data. 

If the screen looks distorted, resize your terminal window. The text display needs a standard width to align correctly. Pressing `F5` refreshes the display if the metrics freeze or fail to update. 

## ⚙️ Usage Tips

- Keep the window open in the background while you perform your normal work. 
- Use the recording feature before you launch a demanding game or application. 
- Compare results after you close a program. 
- If your computer feels slow, check the CPU column to find the process with the highest percentage. 
- You end the program at any time by pressing the `Q` key. This closes the process list and ends the monitor tasks safely.