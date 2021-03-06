;
; FastBasic - Fast basic interpreter for the Atari 8-bit computers
; Copyright (C) 2017-2019 Daniel Serpell
;
; This program is free software; you can redistribute it and/or modify
; it under the terms of the GNU General Public License as published by
; the Free Software Foundation, either version 2 of the License, or
; (at your option) any later version.
;
; This program is distributed in the hope that it will be useful,
; but WITHOUT ANY WARRANTY; without even the implied warranty of
; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
; GNU General Public License for more details.
;
; You should have received a copy of the GNU General Public License along
; with this program.  If not, see <http://www.gnu.org/licenses/>
;
; In addition to the permissions in the GNU General Public License, the
; authors give you unlimited permission to link the compiled version of
; this file into combinations with other programs, and to distribute those
; combinations without any restriction coming from the use of this file.
; (The General Public License restrictions do apply in other respects; for
; example, they cover modification of the file, and distribution when not
; linked into a combine executable.)


; Writes a 16-bit value to an address
; -----------------------------------

        .import         stack_l, stack_h, get_op_var
        .importzp       next_instruction, sptr, cptr
        .exportzp       saddr

        .zeropage
saddr:  .res 2

        .segment        "RUNTIME"

.proc   EXE_DPOKE  ; DPOKE SADDR, AX
        ldy     #0
        sta     (saddr), y
        iny
        txa
        sta     (saddr), y
        jmp     next_instruction
.endproc

EXE_VAR_SADDR:     ; SADDR = VAR address
        jsr     get_op_var
.proc   EXE_SADDR  ; SADDR = AX
        sta     saddr
        stx     saddr+1
        jmp     next_instruction
.endproc

        .include "../deftok.inc"
        deftoken "DPOKE"
        deftoken "SADDR"
        deftoken "VAR_SADDR"

; vi:syntax=asm_ca65
