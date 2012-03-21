Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-pz0-f46.google.com ([209.85.210.46]:43556 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755527Ab2CUOx4 (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Wed, 21 Mar 2012 10:53:56 -0400
Received: by dajr28 with SMTP id r28so1700180daj.19
        for <util-linux@vger.kernel.org>; Wed, 21 Mar 2012 07:53:55 -0700 (PDT)
MIME-Version: 1.0
Date: Wed, 21 Mar 2012 15:53:55 +0100
Message-ID: <CANXSoSB_JTjcwfCPu6vJLdtLtR5e1M4VHJiDu2NpGo=hp6SMrA@mail.gmail.com>
Subject: hexsyntax.c using strtol on the offset parameter
From: Simon de Vlieger <simon@ikanobori.jp>
To: util-linux@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Hi,

I'd like to start out that I'm not a huge C buff but now a tad here
and there. Now a friend of mine called David Trail noticed while
trying to hexdump the last sector of his 1 TB drive that he got what
seems to be an overflow on hexdump:

david@tiamat:~ $ sudo hexdump -s3364995079 -n64 /dev/sda > tmp1
david@tiamat:~ $ sudo hexdump -s10002048860167 -n64 /dev/sda > tmp2
david@tiamat:~ $ diff tmp1 tmp2
david@tiamat:~ $

The line I think I have it narrowed down to is line 92 of
util-linux/hexsyntax.c where the -s parameter is converted to a long.
Sadly the size of a 1 TB disk overflows the size of a long. Can the
off_t maybe be changed to use off64_t (if this is relevant) and use
strtoull instead of strtol? I think it might give some space in the
near future.

Thanks in advance,

Simon de Vlieger
