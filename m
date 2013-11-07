Return-Path: util-linux-owner@vger.kernel.org
Received: from mailout05.t-online.de ([194.25.134.82]:49279 "EHLO
	mailout05.t-online.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750961Ab3KGR3O (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Thu, 7 Nov 2013 12:29:14 -0500
Date: 07 Nov 2013 18:24:00 +0100
From: Hullen@t-online.de (Helmut Hullen)
To: util-linux@vger.kernel.org
Message-ID: <ChQYyP0eCXB@helmut.hullen.de>
In-Reply-To: <20131107114556.GB2853@x2.net.home>
Subject: Re: detecting SMP CPU
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: helmut@hullen.de
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Hallo, Karel,

Du meintest am 07.11.13:

>> I want to detect the existence of an SMP CPU (multi core CPU). I've
>> tried the contents of "/proc/cpuinfo" and the output of "lscpu".

[...]

>> Is there any way to detect a multi core CPU under a kernel which is
>> compiled with "SMP=n"?

>  If you don't want to rely on kernel information than you probably
>  have to use CPUID and some assembler magic to get CPU topology

>  http://wiki.osdev.org/Detecting_CPU_Topology_(80x86)

>  or maybe you can use CPU flags from /proc/cpuinfo (I guess the flags
>  does not depend on SMP=y/n.

>  It's probably better to ask at lkml :-)

Thank you - i'm still (re-)searching.

Viele Gruesse!
Helmut
