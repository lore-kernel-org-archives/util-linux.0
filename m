Return-Path: util-linux-owner@vger.kernel.org
Received: from hrndva-omtalb.mail.rr.com ([71.74.56.122]:27958 "EHLO
	hrndva-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750796Ab2C0R0R (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Tue, 27 Mar 2012 13:26:17 -0400
Received: from [127.0.0.1] (AlThor.int.intellitree.com [172.20.0.44])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by orion.intree.net (Postfix) with ESMTPSA id 6588144D003B
	for <util-linux@vger.kernel.org>; Tue, 27 Mar 2012 13:26:15 -0400 (EDT)
Message-ID: <4F71F836.4000103@intellitree.com>
Date: Tue, 27 Mar 2012 13:26:14 -0400
From: Michael Conrad <mconrad@intellitree.com>
MIME-Version: 1.0
To: util-linux@vger.kernel.org
Subject: blkid -o value
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Hi, I've just had a semi-serious problem related to blkid's "-o value" 
format.

When I first discovered that output format, I assumed that it would be a 
stable script-friendly output format intended for people who don't want 
to parse the name/value pairs.  The fields appeared to be
   LABEL
   UUID
   TYPE
and I wrote a script assuming the third one was TYPE.

However, suddenly the output has changed to be
   LABEL
   UUID
   SEC_TYPE <-- "ext2"
   TYPE <-- "ext3"

which caused my script to mount a ext3 partition as ext2, killing the 
journal.

Looking at the code, it appears that it iterates over some list coming 
from libblkid and prints a line with the value only if the value 
exists.  So it appears that there was never any intention of it being a 
stable output.

I would request that either the order of fields become stable by 
printing empty lines for missing fields (and documented), or the "-o 
value" be done away with, since I can't see any reason anyone would want 
random output in a script-friendly format, and the fact that it exists 
is likely to lead people astray.

Thoughts?  Comments?

-Mike Conrad
