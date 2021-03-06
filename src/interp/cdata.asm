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


; Read constant data
; ------------------

        .import         EXE_JUMP
        .importzp       cptr, saddr

        .segment        "RUNTIME"

.proc   EXE_CDATA       ; *(SADDR) = address of data

        ; Store (cptr) + 2 to var address

        ldy     #0
        lda     cptr
        clc
        adc     #2
        sta     (saddr), y
        iny
        lda     cptr+1
        adc     #0
        sta     (saddr), y

        ; ldy     sptr ; EXE_JUMP does not use Y=sptr
        jmp     EXE_JUMP
.endproc

        .include "../deftok.inc"
        deftoken "CDATA"

; vi:syntax=asm_ca65
