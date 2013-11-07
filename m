Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:20111 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751142Ab3KGLqC (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Thu, 7 Nov 2013 06:46:02 -0500
Date: Thu, 7 Nov 2013 12:45:56 +0100
From: Karel Zak <kzak@redhat.com>
To: helmut@hullen.de
Cc: util-linux@vger.kernel.org
Subject: Re: detecting SMP CPU
Message-ID: <20131107114556.GB2853@x2.net.home>
References: <CedICKtuCXB@helmut.hullen.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CedICKtuCXB@helmut.hullen.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Fri, Sep 27, 2013 at 05:04:00PM +0200, Helmut Hullen wrote:
> I want to detect the existence of an SMP CPU (multi core CPU). I've  
> tried the contents of "/proc/cpuinfo" and the output of "lscpu".
> 
> Both ways only showed the existence of both processors of my AMD CPU  
> when I run them under a kernel which was compiled with the option  
> "SMP=Y".
> 
> The "help" for this kernel option proposes to set this option only if  
> the kernel really runs on such a CPU.
> 
> Is there any way to detect a multi core CPU under a kernel which is  
> compiled with "SMP=n"?

 If you don't want to rely on kernel information than you probably
 have to use CPUID and some assembler magic to get CPU topology

 http://wiki.osdev.org/Detecting_CPU_Topology_(80x86)

 or maybe you can use CPU flags from /proc/cpuinfo (I guess the flags 
 does not depend on SMP=y/n.

 It's probably better to ask at lkml :-)

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
