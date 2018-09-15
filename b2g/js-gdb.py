""" GDB Python customization auto-loader for js shell """

import os.path
sys.path[0:0] = [os.path.join('/home/leo/release/quoin/src/gecko/js/src', 'gdb')]

import mozilla.autoload
mozilla.autoload.register(gdb.current_objfile())

import mozilla.asmjs
mozilla.asmjs.install()
