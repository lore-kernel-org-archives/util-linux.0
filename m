Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-pa0-f53.google.com ([209.85.220.53]:48790 "EHLO
	mail-pa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753438AbaHEWg7 (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Tue, 5 Aug 2014 18:36:59 -0400
Received: by mail-pa0-f53.google.com with SMTP id rd3so2206435pab.12
        for <util-linux@vger.kernel.org>; Tue, 05 Aug 2014 15:36:59 -0700 (PDT)
MIME-Version: 1.0
Reply-To: kerolasa@gmail.com
In-Reply-To: <20140804115556.GA6923@x2.net.home>
References: <1407107290-5806-1-git-send-email-kerolasa@iki.fi>
	<20140804115556.GA6923@x2.net.home>
Date: Tue, 5 Aug 2014 23:36:59 +0100
Message-ID: <CAG27Bk29oWnsjQDHJJmvENsr9ghcnq0soOFCx3fzEJ1SYMmfFQ@mail.gmail.com>
Subject: Re: [PATCH 8/8] zramctl: allow use of --algorithm and --streams alone
From: Sami Kerola <kerolasa@iki.fi>
To: Karel Zak <kzak@redhat.com>
Cc: util-linux <util-linux@vger.kernel.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On 4 August 2014 12:55, Karel Zak <kzak@redhat.com> wrote:
> On Mon, Aug 04, 2014 at 12:08:10AM +0100, Sami Kerola wrote:
>> Earlier the --algorithm and --streams had to be combined with --size.  To
>> user requirement to combine with --size was indirectly told using
>> following message.
>
> And is it really supported by kernel? I see in
> Documentation/blockdev/zram.txt:
>
>  In order to enable compression backend's multi stream support
>  max_comp_streams must be initially set to desired concurrency
>  level before ZRAM device initialisation.
>
> I guess that when you set disksize the zram device is "locked" for
> setting changes. It means that modify already initialized (created)
> zram devices is impossible. You have to reset the device to "unlock"
> the device setting.

After playing with zramctl I found out --algorithm must be set before
--size. The --streams can be set after --size, but not if device is in use.
When device is in use none of the settings are allowed.

$ ./zramctl
NAME       ALGORITHM DISKSIZE DATA COMPR TOTAL STREAMS MOUNTPOINT
/dev/zram0 lzo           100K   4K   76B    4K       2 [SWAP]
/dev/zram2 lzo            44K   0B    0B    0B       1
/dev/zram3 lzo             1M  40K  796B   40K       1 /mnt
$ ./zramctl zram1
NAME  ALGORITHM DISKSIZE DATA COMPR TOTAL STREAMS MOUNTPOINT
zram1 lzo             0B   0B    0B    0B       1

$ ./zramctl --algorithm lz4 zram1 ; echo $?
0
$ ./zramctl --algorithm lz4 zram2 ; echo $?
zramctl: zram2: failed to set algorithm: Device or resource busy
1
$ ./zramctl --algorithm lz4 zram3 ; echo $?
zramctl: zram3: failed to set algorithm: Device or resource busy
1

$ ./zramctl --stream 2 zram1 ; echo $?
0
$ ./zramctl --stream 2 zram2 ; echo $?
0
$ ./zramctl --stream 2 zram3 ; echo $?
zramctl: zram3: failed to set number of streams: Invalid argument
1

Whether the case --streams 2 zram2 in above example is correct or a
bug is a question to kernel developers (Sergey is CC'd). Looking the
commit message

http://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/?id=fe8eb122c82b2049c460fc6df6e8583a2f935cff

the device behavior might be bug.

-- 
Sami Kerola
http://www.iki.fi/kerolasa/
