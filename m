Return-Path: util-linux-owner@vger.kernel.org
Received: from message.langara.bc.ca ([142.35.159.25]:63248 "EHLO
	message.langara.bc.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750918AbaHPW55 (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sat, 16 Aug 2014 18:57:57 -0400
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Received: from langara.bc.ca ([127.0.0.1])
 by message.langara.bc.ca (Sun Java(tm) System Messaging Server 6.3-6.03 (built
 Mar 14 2008; 32bit)) with ESMTP id <0NAF00CZL6CKPOC0@message.langara.bc.ca>
 for util-linux@vger.kernel.org; Sat, 16 Aug 2014 14:57:56 -0700 (PDT)
From: Steven Stewart-Gallus <sstewartgallus00@mylangara.bc.ca>
To: util-linux@vger.kernel.org
Message-id: <fbcec6cf5352.53efd3e4@langara.bc.ca>
Date: Sat, 16 Aug 2014 21:57:56 +0000 (GMT)
Subject: Utilities don't take into account capabilities
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

The utilities such as mount don't take into account capabilities and always fail
for non root users which is wrong.

This is really, really, really annoying when working in a sandboxed non root
shell with pseudo capabilities.

One possible solution to my problem is do some complicated checking for
capabilities that I don't even know how would work. I believe a better and
simpler approach that would work for possible future extensions as well would be
to simply drop privileges whenever one is unprivileged and attempt to do the
task as normally. If you felt like it, a warning along the lines of "warning:
user is unprivileged, attempting mount without privileges" could be made. As a
bonus, failed system calls can sometimes leave important diagnostic information
in the dmesg.

Thank you,
Steven Stewart-Gallus
