Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-we0-f177.google.com ([74.125.82.177]:64583 "EHLO
	mail-we0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932183AbaGSR2Z (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sat, 19 Jul 2014 13:28:25 -0400
Received: by mail-we0-f177.google.com with SMTP id w62so5833299wes.36
        for <util-linux@vger.kernel.org>; Sat, 19 Jul 2014 10:28:24 -0700 (PDT)
Received: from beplan.lan (nat3-minsk-pool-46-53-181-8.telecom.by. [46.53.181.8])
        by mx.google.com with ESMTPSA id a13sm23308513wjs.12.2014.07.19.10.28.23
        for <util-linux@vger.kernel.org>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 19 Jul 2014 10:28:23 -0700 (PDT)
Message-ID: <53CAAAB6.6020607@gmail.com>
Date: Sat, 19 Jul 2014 20:28:22 +0300
From: Timofey Titovets <nefelim4ag@gmail.com>
MIME-Version: 1.0
To: util-linux@vger.kernel.org
Subject: [RFC] Zram handle util
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Good time of day.
I want hear your opinions.
Several days ago, i writed zramctl util (on C++) for have useful app for 
setup zrams..
Code hosted her: https://github.com/Nefelim4ag/zramctl

Examples:
zramctl find # return name of first free device (zram0)
zramctl find 1024M lz4 4 # (i not implement -? options now)
			 # 4 - threads
			 # setup and return name of device (zram1)
zramctl reset zram0 zram1 ...


I want to port it on C and try include it in util-linux, like losetup.
It has a sense? What do you think?
