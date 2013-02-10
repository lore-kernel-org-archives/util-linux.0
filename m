Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-vb0-f48.google.com ([209.85.212.48]:45532 "EHLO
	mail-vb0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756375Ab3BJVES (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 10 Feb 2013 16:04:18 -0500
Received: by mail-vb0-f48.google.com with SMTP id fc21so3377228vbb.21
        for <util-linux@vger.kernel.org>; Sun, 10 Feb 2013 13:04:17 -0800 (PST)
MIME-Version: 1.0
Reply-To: kerolasa@gmail.com
In-Reply-To: <BLU0-SMTP36414270EB979DF67318E53D50B0@phx.gbl>
References: <BLU0-SMTP36414270EB979DF67318E53D50B0@phx.gbl>
Date: Sun, 10 Feb 2013 21:04:16 +0000
Message-ID: <CAG27Bk2XQxWUFZPuQP8JWJaJ5OuCrxspk==9saGO-Xv6yk=7Sg@mail.gmail.com>
Subject: Re: Hypervisor & Virtualization lscpu test fail
From: Sami Kerola <kerolasa@iki.fi>
To: Luis Aranguren <pizzaman@hotmail.com>
Cc: util-linux@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Sun, Feb 10, 2013 at 4:25 PM, Luis Aranguren <pizzaman@hotmail.com> wrote:
> Hi, I'm trying to package util-linux for exherbo, a source based distro.
>
> util-linux's lscpu tests fail when compiled on a VM running under a VMware Vsphere esxi hypervisor.
>
> #cat ./C/64/tests/diff/lscpu/lscpu-x86_64-64cpu
> --- /var/tmp/paludis/build/sys-apps-util-linux-2.22.2/work/util-linux-2.22.2/tests/expected/lscpu/lscpu-x86_64-64cpu    2012-10-15 10:09:42.000000000 +0000
> +++ /var/tmp/paludis/build/sys-apps-util-linux-2.22.2/work/C/64/tests/output/lscpu/lscpu-x86_64-64cpu   2013-02-09 03:35:37.000000000 +0000
> @@ -12,6 +12,8 @@
>  CPU MHz:               1064.000
>  BogoMIPS:              3989.44
>  Virtualization:        VT-x
> +Hypervisor vendor:     VMware
> +Virtualization type:   full
>  L1d cache:             32K
>  L1i cache:             32K
>  L2 cache:              256K
>
>
> # lscpu
> Architecture:          x86_64
> CPU op-mode(s):        32-bit, 64-bit
> Byte Order:            Little Endian
> CPU(s):                2
> On-line CPU(s) list:   0,1
> Thread(s) per core:    1
> Core(s) per socket:    2
> Socket(s):             1
> NUMA node(s):          1
> Vendor ID:             AuthenticAMD
> CPU family:            16
> Model:                 6
> Stepping:              3
> CPU MHz:               1497.506
> BogoMIPS:              2995.01
> Hypervisor vendor:     VMware
> Virtualization type:   full
> L1d cache:             64K
> L1i cache:             64K
> L2 cache:              1024K
> NUMA node0 CPU(s):     0,1
>
> How can I solve this?
> Luis Aranguren

Hi Luis,

I have a hunch best way to proceed is to get cpu data from your /proc.
This can be achieved easiest by running a lscpu test data collector
script.

cd src/util-linux
sh tests/ts/lscpu/mk-input.sh vmware-esxi

After running the script you can find file vmware-esxi.tar.gz in
current directory. Please send the file to mail list, and inform if it
can be added to be part of regression test suite (which would of
course is much preferred).

-- 
   Sami Kerola
   http://www.iki.fi/kerolasa/
