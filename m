Return-Path: util-linux-owner@vger.kernel.org
Received: from investici.nine.ch ([217.150.252.179]:60201 "EHLO
	confino.investici.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758605Ab2HJVpf (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Fri, 10 Aug 2012 17:45:35 -0400
Received: from [217.150.252.179] (confino [217.150.252.179]) (Authenticated sender: oijjjio@autistici.org) by localhost (Postfix) with ESMTPSA id 7EC00C865B
	for <util-linux@vger.kernel.org>; Fri, 10 Aug 2012 21:45:30 +0000 (UTC)
Date: Fri, 10 Aug 2012 23:44:35 +0200
From: Naja Melan <najamelan@autistici.org>
To: util-linux@vger.kernel.org
Subject: umount failing on paths which end in a backslash
Message-ID: <20120810234435.6af1f6d1@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

I tried to report this bug months ago to the debian maintainers of mount, but debian bug reporting is a minefield and by email all I got was a lousy answer from someone who didn't understand escaping in bash strings and who obviously never ran the script demonstrating the issue. 

Given that this is rather fundamental flaw I decided to post it here. I never tested on anything but debian testing and I don't know if this bug still exists in the latest build.

My version:

mount from util-linux 2.20.1 (with libblkid and selinux support)


The problem is that on ext path names ending in backslash are valid. Mount manages to mount something on them but umount chokes. It looks like somewhere on the way there is an escaping issue.

The following script demonstrates the problem. Obviously you should change cdrom1 to something that exists and that you want to mount.


#!/bin/bash

mkdir 'te\st\'
sudo mount -r /dev/cdrom1 'te\st\'
ls 'te\st\'

echo -e "\n\nmount:"
mount
echo -e "\n\n/proc/mounts:"
cat /proc/mounts
echo -e "\n\numount:"

sudo umount /dev/cdrom1


Abbreviated Output:

...
mount:
...
/dev/sr0 on /media/../te\st\134 type udf (ro,relatime,utf8)
...
cat /proc/mounts:
...
/dev/sr0 /media/.../te\134st\134 udf ro,relatime,utf8 0 0
...
umount: /media/.../te\st\134: not found

Somehow this shows a difference in unescaping between the backslash in the middle and the backslash in the end, which does not get converted back from \134. Note that paths with backslashes in the middle do not suffer from this problem.

Greetings
Naja Melan



