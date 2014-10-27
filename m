Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-pa0-f45.google.com ([209.85.220.45]:34194 "EHLO
	mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751602AbaJ0Snf (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Mon, 27 Oct 2014 14:43:35 -0400
Received: by mail-pa0-f45.google.com with SMTP id lf10so3572008pab.18
        for <util-linux@vger.kernel.org>; Mon, 27 Oct 2014 11:43:35 -0700 (PDT)
Received: from [192.168.1.2] ([59.89.143.167])
        by mx.google.com with ESMTPSA id fv4sm11489421pbd.47.2014.10.27.11.43.33
        for <util-linux@vger.kernel.org>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 27 Oct 2014 11:43:34 -0700 (PDT)
Message-ID: <544E923E.6050406@gmail.com>
Date: Tue, 28 Oct 2014 00:13:10 +0530
From: dE <de.techno@gmail.com>
MIME-Version: 1.0
To: util-linux@vger.kernel.org
Subject: fdisk and 2048 sectors obsession.
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Hi!

I was learning about GPT when I noticed this behavior of fdisk which I 
never though about before.

Regardless of the partition table, fdisk always starts the first 
partition at 2048. In reality, the maximum size required by the gap 
between MBR and the 1st partition is a single sector, which's used by 
GRUB 1.5. GPT doesn't need this space at all.

Then extended partitions too have a gap of 2048 sectors.

Why this behavior?
