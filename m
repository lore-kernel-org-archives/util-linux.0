Return-Path: util-linux-owner@vger.kernel.org
Received: from e28smtp03.in.ibm.com ([122.248.162.3]:32970 "EHLO
	e28smtp03.in.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753835Ab2HEKbr (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 5 Aug 2012 06:31:47 -0400
Received: from /spool/local
	by e28smtp03.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <util-linux@vger.kernel.org> from <faizanh@linux.vnet.ibm.com>;
	Sun, 5 Aug 2012 16:01:44 +0530
Received: from d28av03.in.ibm.com (d28av03.in.ibm.com [9.184.220.65])
	by d28relay04.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id q75AVUVR23920662
	for <util-linux@vger.kernel.org>; Sun, 5 Aug 2012 16:01:30 +0530
Received: from d28av03.in.ibm.com (loopback [127.0.0.1])
	by d28av03.in.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id q75AVUU9014058
	for <util-linux@vger.kernel.org>; Sun, 5 Aug 2012 20:31:30 +1000
Received: from [9.77.204.36] ([9.77.204.36])
	by d28av03.in.ibm.com (8.14.4/8.13.1/NCO v10.0 AVin) with ESMTP id q75AVTcX014053
	for <util-linux@vger.kernel.org>; Sun, 5 Aug 2012 20:31:29 +1000
Message-ID: <501E4B80.1010003@linux.vnet.ibm.com>
Date: Sun, 05 Aug 2012 16:01:28 +0530
From: faizan husain <faizanh@linux.vnet.ibm.com>
MIME-Version: 1.0
To: util-linux@vger.kernel.org
Subject: lscpu command produces incorrect output with the options -b and -c
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Options for lscpu command are giving incorrect output. As per the man page or help,
'-b' option should limit the output to online CPUs  and
'-c' option should limit the output to offline CPUs.
But we could see the output is same for '-a','-b' and '-c' options.

---Steps to Reproduce---
  [root@mx3650m2 ~]# lscpu -a
...
...
CPU(s):                16
On-line CPU(s) list:   0-5,7-13,15
Off-line CPU(s) list:  6,14
...
...

[root@mx3650m2 ~]# lscpu -b
Architecture:          x86_64
...
...
CPU(s):                16
On-line CPU(s) list:   0-5,7-13,15
Off-line CPU(s) list:  6,14
...
...

[root@mx3650m2 ~]# lscpu -c
...
...
CPU(s):                16
On-line CPU(s) list:   0-5,7-13,15
Off-line CPU(s) list:  6,14
...
...

patch in the next mail fixes this issue.

Thanks
Faizan

