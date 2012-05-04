Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-pb0-f46.google.com ([209.85.160.46]:45191 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750807Ab2EDF4E (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Fri, 4 May 2012 01:56:04 -0400
Received: by pbbrp8 with SMTP id rp8so3406242pbb.19
        for <util-linux@vger.kernel.org>; Thu, 03 May 2012 22:56:04 -0700 (PDT)
From: Justin Bogner <mail@justinbogner.com>
To: util-linux@vger.kernel.org
Subject: sfdisk: Problem with -N and resizing extended partitions
Date: Thu, 03 May 2012 23:54:53 -0600
Message-ID: <874nrwh4nm.fsf@glimpse.justinbogner.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Hi,

I've run into a problem with sfdisk where resizing an extended partition
doesn't do the right thing. I have an extended partition at /dev/sda4
that has four partitions, so the last partition is /dev/sda8, and I want
to extend /dev/sda8 to the maximum possible size. So I issue these two
commands:

    echo ,+, | sfdisk -N4 /dev/sda
    echo ,+, | sfdisk -N8 /dev/sda

This grows /dev/sda4 to the maximum size, but /dev/sda8 is unchanged.
This also occurs if I calculate the sizes by hand instead of using `+`.

The problem happens during the first command. The size of /dev/sda4 is
updated in the MBR, but none of the EBRs are changed, so the lengths of
each of the extended partitions in the EBRs are wrong.

You can work around this problem by issuing the following after resizing
the extended partition:

    sfdisk -d /dev/sda | sfdisk /dev/sda

This will rebuild the EBRs so that they're consistent with the length of
the extended partition in the MBR.

Let me know if you need any more info or if my explanation of the
problem isn't clear.

-- 
Justin Bogner
