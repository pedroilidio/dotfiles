from IPython import get_ipython
from prompt_toolkit.enums import DEFAULT_BUFFER
from prompt_toolkit.filters import HasFocus, ViInsertMode, ViNavigationMode
from prompt_toolkit.key_binding.vi_state import InputMode
from functools import partial

keybindings = get_ipython().pt_app.key_bindings

vi_navigation_mode_keybinding = partial(keybindings.add, filter=HasFocus(DEFAULT_BUFFER) & ViNavigationMode())
vi_insert_mode_keybinding = partial(keybindings.add, filter=HasFocus(DEFAULT_BUFFER) & ViInsertMode())

@vi_insert_mode_keybinding("j", "f")
@vi_insert_mode_keybinding("f", "j")
def switch_to_navigation_mode(event):
    event.cli.vi_state.input_mode = InputMode.NAVIGATION
