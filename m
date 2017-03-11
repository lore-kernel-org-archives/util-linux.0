Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.17.21]:52298 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932827AbdCKOd4 (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Sat, 11 Mar 2017 09:33:56 -0500
Subject: Re: ideas of what lib might be missing? (2.29.2 has missing symbols @
 link)
To: L A Walsh <lkml@tlinx.org>, util-linux@vger.kernel.org
References: <58C3F064.4060904@tlinx.org>
From: J William Piggott <elseifthen@gmx.com>
Message-ID: <0b737f79-ed0d-53f0-bbf7-2b4e44be7543@gmx.com>
Date: Sat, 11 Mar 2017 09:33:43 -0500
MIME-Version: 1.0
In-Reply-To: <58C3F064.4060904@tlinx.org>
Content-Type: text/plain; charset=windows-1252
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>



On 03/11/2017 07:41 AM, L A Walsh wrote:
> I thought 'configure' was supposed to test for what was present and
> what was missing?  Seems to have missed a few... :-(
> 
> 
> In trying to make new release 2.29.2, I'm getting several undefined
> symbols:
> 
> color_fdisable
> 
> color_scheme_fenable
> 
> color_sequence_from_colorname
> 
> colormode_or_err
> 
> colors_init get_fd_tabsize
> 
> get_terminal_name
> 
> initproctitle
> 
> pager_redirect
> 
> parse_kmsg_recordsetproctitle
> 
> plymouth_command
> 
> string_to_bitarray
> 
> strnchr strtimeval_iso
> 
> strtos32_or_err
> 
> strtou32_or_err
> 
> unhexmangle_to_buffer
> 

These are all in util-linux/src/include/*.h

Where did you get your util-linux source from?


> --- Was wondering what library I might be missing?  or why they are
> being referenced when 'whatever library' they are in, evidently isn't
> on my system...  configure bug?
> 
> I just ran the existing configure with the options listed further on
> down...
> 
> Thanks!  -linda
> 
> 
> 
> 
> uname -a: Linux Ishtar 4.10.1-Isht-Van #1 SMP PREEMPT Tue Feb 28
> 18:57:48 PST 2017 x86_64 GNU/Linux
> 
> gcc (SUSE Linux) 4.9.0
> 
> glibc: Name        : glibc Version     : 2.19 Release     : 16.9.1
> 
> vendor openSuSE 13.2
> 
> options:
> 
> array enable=(
>               
> fs-paths-default
> 
>               
> last libmount-support-mtab line
>               
> newgrp
>               
> reset
>               
> static-programs=mount sulogin-emergency-mount
> 
>               
> vipw write
> 
> ) array disable=( assert nls pylibmount) array with=(   audit
>               
> bashcompletiondir=/usr/share/bash-completion
> 
>               
> gnu-ld
>               
> readline) array without=( python )
> 
> 
> -- To unsubscribe from this list: send the line "unsubscribe
> util-linux" in
> 
> the body of a message to majordomo@vger.kernel.org
> 
> More majordomo info at http://vger.kernel.org/majordomo-info.html
> 
> 
