Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-oi0-f42.google.com ([209.85.218.42]:40920 "EHLO
	mail-oi0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752010AbaIGSTI (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 7 Sep 2014 14:19:08 -0400
Received: by mail-oi0-f42.google.com with SMTP id e131so1879311oig.29
        for <util-linux@vger.kernel.org>; Sun, 07 Sep 2014 11:19:07 -0700 (PDT)
Received: from [192.168.0.75] (cpe-72-178-123-130.satx.res.rr.com. [72.178.123.130])
        by mx.google.com with ESMTPSA id c3sm5061319obf.14.2014.09.07.11.19.05
        for <util-linux@vger.kernel.org>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 07 Sep 2014 11:19:06 -0700 (PDT)
Message-ID: <540CA199.8070307@gmail.com>
Date: Sun, 07 Sep 2014 13:19:05 -0500
From: Bruce Dubbs <bruce.dubbs@gmail.com>
MIME-Version: 1.0
To: util-linux@vger.kernel.org
Subject: mount error message
Content-Type: text/plain; charset=UTF-8; format=flowed
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

I have a user that complains that mount is giving an incorrect error 
message under some circumstances.  For instance if mtab is symlinked to 
/proc/self/mounts the command and /run is not in fstab:

$ mount /run

returns an error message:

   mount: /run: No such file or directory

However if mtab is a regular file, the error message is:

   mount: can't find /run in /etc/fstab

It would be appropriate if both situations could return the 2nd message.

   -- Bruce Dubbs
      linuxfromscratch.org
