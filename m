Return-Path: util-linux-owner@vger.kernel.org
Received: from ishtar.tlinx.org ([173.164.175.65]:42160 "EHLO
        Ishtar.sc.tlinx.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751817AbdCKNNl (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Sat, 11 Mar 2017 08:13:41 -0500
Received: from [192.168.3.12] (Athenae [192.168.3.12])
        by Ishtar.sc.tlinx.org (8.14.7/8.14.4/SuSE Linux 0.8) with ESMTP id v2BCf8IU069456
        for <util-linux@vger.kernel.org>; Sat, 11 Mar 2017 04:41:10 -0800
Message-ID: <58C3F064.4060904@tlinx.org>
Date: Sat, 11 Mar 2017 04:41:08 -0800
From: L A Walsh <lkml@tlinx.org>
MIME-Version: 1.0
To: util-linux@vger.kernel.org
Subject: ideas of what lib might be missing?  (2.29.2 has missing symbols
 @ link)
Content-Type: text/plain; charset=UTF-8; format=flowed
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

I thought 'configure' was supposed to test for what was present
and what was missing?  Seems to have missed a few... :-(

In trying to make new release 2.29.2, I'm getting
several undefined symbols:

color_fdisable
color_scheme_fenable
color_sequence_from_colorname
colormode_or_err
colors_init
get_fd_tabsize
get_terminal_name
initproctitle
pager_redirect
parse_kmsg_recordsetproctitle
plymouth_command
string_to_bitarray
strnchr
strtimeval_iso
strtos32_or_err
strtou32_or_err
unhexmangle_to_buffer
---
Was wondering what library I might be missing? or why they
are being referenced when 'whatever library' they are in,
evidently isn't on my system...  configure bug?

I just ran the existing configure with the options listed
further on down...

Thanks!
-linda




uname -a:
Linux Ishtar 4.10.1-Isht-Van #1 SMP PREEMPT Tue Feb 28 18:57:48 PST 2017 
x86_64 GNU/Linux

gcc (SUSE Linux) 4.9.0

glibc:
Name        : glibc
Version     : 2.19
Release     : 16.9.1

vendor openSuSE 13.2

options:

array enable=( 
                fs-paths-default
                last libmount-support-mtab line
                newgrp
                reset
                static-programs=mount sulogin-emergency-mount
                vipw write
)
array disable=( assert nls pylibmount )
array with=(    audit
                bashcompletiondir=/usr/share/bash-completion
                gnu-ld
                readline
)
array without=( python )


