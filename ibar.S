    .text
    .global test
    .global template_s
    .global template_e
template_s:
test:
    la.pcrel $a1, loop
    la.pcrel $a2, inst
    ld.wu   $a3, $a2, 0
    ld.wu   $a4, $a2, 4

loop:
    li.d    $t0, 4
    st.w    $a3, $a1, 4 * 15
    ibar    0
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    st.w    $a3, $a1, 4 * 31
    ibar    0
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    st.w    $a3, $a1, 4 * 47
    ibar    0
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    st.w    $a3, $a1, 4 * 63
    ibar    0
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop

    st.w    $a4, $a1, 4 * 15
    st.w    $a4, $a1, 4 * 31
    st.w    $a4, $a1, 4 * 47
    st.w    $a4, $a1, 4 * 63

    beqz    $t0, loop
    jirl    $zero, $ra, 0

inst:
    addi.d  $t0, $t0, -1
    nop
template_e:
