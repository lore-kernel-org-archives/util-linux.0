Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-pa0-f41.google.com ([209.85.220.41]:49889 "EHLO
	mail-pa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751895AbbASQLg (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Mon, 19 Jan 2015 11:11:36 -0500
Received: by mail-pa0-f41.google.com with SMTP id rd3so39662268pab.0
        for <util-linux@vger.kernel.org>; Mon, 19 Jan 2015 08:11:36 -0800 (PST)
Received: from [192.168.1.2] ([59.97.240.171])
        by mx.google.com with ESMTPSA id rl10sm481365pbb.67.2015.01.19.08.11.34
        for <util-linux@vger.kernel.org>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 19 Jan 2015 08:11:35 -0800 (PST)
Message-ID: <54BD2CB4.5050308@gmail.com>
Date: Mon, 19 Jan 2015 21:41:32 +0530
From: dE <de.techno@gmail.com>
MIME-Version: 1.0
To: util-linux@vger.kernel.org
Subject: Add to man page: 0 as prio when -i, -b
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

As we know the batch and idle algorithms don't have priorities. But chrt 
expects '0' as the priority, otherwise the command fails.

# chrt -i cat /etc/fstab

chrt - manipulate real-time attributes of a process

Set policy:
   chrt [options] [<policy>] <priority> [-p <pid> | <command> [<arg>...]]
...
...
...




# chrt -i 0 cat /etc/fstab
# /etc/fstab: static file system information.
#
# noatime turns off atimes for increased performance (atimes normally aren't
...
...
...

