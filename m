Return-Path: util-linux-owner@vger.kernel.org
Received: from e23smtp02.au.ibm.com ([202.81.31.144]:56410 "EHLO
	e23smtp02.au.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751931AbaE2LoP (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Thu, 29 May 2014 07:44:15 -0400
Received: from /spool/local
	by e23smtp02.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <util-linux@vger.kernel.org> from <jananive@linux.vnet.ibm.com>;
	Thu, 29 May 2014 21:44:12 +1000
Received: from d23relay03.au.ibm.com (d23relay03.au.ibm.com [9.190.235.21])
	by d23dlp02.au.ibm.com (Postfix) with ESMTP id 56FC12BB0040
	for <util-linux@vger.kernel.org>; Thu, 29 May 2014 21:44:10 +1000 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
	by d23relay03.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id s4TBhs0511927980
	for <util-linux@vger.kernel.org>; Thu, 29 May 2014 21:43:54 +1000
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
	by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id s4TBi9vr016954
	for <util-linux@vger.kernel.org>; Thu, 29 May 2014 21:44:10 +1000
Message-ID: <53871D87.2070401@linux.vnet.ibm.com>
Date: Thu, 29 May 2014 17:14:07 +0530
From: Janani Venkataraman <jananive@linux.vnet.ibm.com>
MIME-Version: 1.0
To: util-linux@vger.kernel.org
CC: "Suzuki K. Poulose" <suzuki@in.ibm.com>, ananth@linux.vnet.ibm.com,
        Tarundeep Singh <tarundsk@linux.vnet.ibm.com>
Subject: Non disruptive application core dump infrastructure
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Hi,

We have developed a tool called "gencore" which captures the core of an 
application without
disrupting its process. The dump is collected non-disruptively and this 
tool currently supports
s390, x86 and power systems.

THE TOOL:

The tool can perform non-disruptive third party dumps. The tool also 
contains a library "libgencore"
which helps applicationsto trigger self dumps.

The tool can perform:

1) Third party dump: The pid of the process to dumped is given along 
with name of the core-file to
be created.

eg.

[janani@localhost]:gencore 6616 core.test

2) Self dump: The programs can request a self-dump using gencore() API, 
provided throughlibgencore. This
is implemented through a daemon which listens on a UNIX Filesocket for 
such requests. The daemon is started
immediately post installation. The program which requires the dump makes 
use of the gencore() API and provides
the name of the core-file as a parameter.

eg.

/* Opening the library, in this case the library is present in the 
/usr/lib64 */
lib = dlopen("libgencore.so", RTLD_LAZY);

gencore = dlsym(lib, "gencore");

Call the API:
gencore("/home/janani/core_test").

BASIC IDEA:

The basic idea is that the threads of the process are held using ptrace 
calls and the dump is generated in the
ELF format using the /proc/pid filesystem.

PATCH SET:
We have designed this tool based on the discussions with linux kernel 
community. The patches have been posted
at: https://lkml.org/lkml/2014/3/20/138

Do you think this can be part of the util-linux bundle? We can tweak it 
to make it work as a package in util-linux.

Let us know your reviews and comments.

Thanks.
Janani

