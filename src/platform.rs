use std::{ffi::OsStr, os::windows::ffi::OsStrExt};

use winapi::{
    shared::minwindef::WORD,
    um::winuser::{
        GetAsyncKeyState, INPUT, INPUT_KEYBOARD, KEYBDINPUT, KEYEVENTF_KEYUP, SendInput,
        VK_CONTROL, VK_OEM_MINUS, VK_OEM_PLUS,
    },
};

pub(crate) fn wide_slice_to_string(value: &[u16]) -> String {
    let len = value
        .iter()
        .position(|item| *item == 0)
        .unwrap_or(value.len());
    String::from_utf16_lossy(&value[..len])
}

pub(crate) fn to_wide(value: &str) -> Vec<u16> {
    OsStr::new(value)
        .encode_wide()
        .chain(std::iter::once(0))
        .collect()
}

pub(crate) fn send_terminal_zoom_shortcut(zoom_in: bool) -> std::io::Result<()> {
    let key = if zoom_in {
        VK_OEM_PLUS as WORD
    } else {
        VK_OEM_MINUS as WORD
    };
    let inputs = if control_key_is_down() {
        vec![keyboard_input(key, 0), keyboard_input(key, KEYEVENTF_KEYUP)]
    } else {
        vec![
            keyboard_input(VK_CONTROL as WORD, 0),
            keyboard_input(key, 0),
            keyboard_input(key, KEYEVENTF_KEYUP),
            keyboard_input(VK_CONTROL as WORD, KEYEVENTF_KEYUP),
        ]
    };

    let sent = unsafe {
        SendInput(
            inputs.len() as u32,
            inputs.as_ptr().cast_mut(),
            std::mem::size_of::<INPUT>() as i32,
        )
    };
    if sent == inputs.len() as u32 {
        Ok(())
    } else {
        Err(std::io::Error::last_os_error())
    }
}

fn control_key_is_down() -> bool {
    unsafe { GetAsyncKeyState(VK_CONTROL) < 0 }
}

fn keyboard_input(vk: WORD, flags: u32) -> INPUT {
    let mut input = unsafe { std::mem::zeroed::<INPUT>() };
    input.type_ = INPUT_KEYBOARD;
    unsafe {
        *input.u.ki_mut() = KEYBDINPUT {
            wVk: vk,
            wScan: 0,
            dwFlags: flags,
            time: 0,
            dwExtraInfo: 0,
        };
    }
    input
}
