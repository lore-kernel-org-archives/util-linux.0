Return-Path: util-linux-owner@vger.kernel.org
Received: from mailout07.t-online.de ([194.25.134.83]:51765 "EHLO
	mailout07.t-online.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752639Ab3I0PJ6 (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Fri, 27 Sep 2013 11:09:58 -0400
Date: 27 Sep 2013 17:04:00 +0200
From: Hullen@t-online.de (Helmut Hullen)
To: util-linux@vger.kernel.org
Message-ID: <CedICKtuCXB@helmut.hullen.de>
Subject: detecting SMP CPU
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: helmut@hullen.de
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Hallo, util-linux,

I want to detect the existence of an SMP CPU (multi core CPU). I've  
tried the contents of "/proc/cpuinfo" and the output of "lscpu".

Both ways only showed the existence of both processors of my AMD CPU  
when I run them under a kernel which was compiled with the option  
"SMP=Y".

The "help" for this kernel option proposes to set this option only if  
the kernel really runs on such a CPU.

Is there any way to detect a multi core CPU under a kernel which is  
compiled with "SMP=n"?

Please excuse my gerlish.

Viele Gruesse!
Helmut
