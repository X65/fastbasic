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


; USR - call user assembly routine
; --------------------------------

        .import         stack_l, stack_h
        .importzp       next_instruction, next_ins_incsp, tmp1

        .include "atari.inc"

        .segment        "RUNTIME"

.proc   EXE_USR_PARAM   ; Stores AX as an usr parameter
        pha
        txa
        pha
        jmp     next_instruction
.endproc

.proc   EXE_USR_ADDR
        ; Store out return address into the CPU stack. This should be pushed to the
        ; stack *before* the arguments, so it needs to be a special token.
        jsr     next_instruction
        jmp     next_ins_incsp
.endproc

.proc   EXE_USR_CALL
        ; Calls the routine, address in stack
        lda     stack_l, y
        ldx     stack_h, y
        sta     tmp1
        stx     tmp1+1
        jmp     (tmp1)  ; 7 bytes, 11 cycles
.endproc

        .include "../deftok.inc"
        deftoken "USR_PARAM"
        deftoken "USR_ADDR"
        deftoken "USR_CALL"

; vi:syntax=asm_ca65
