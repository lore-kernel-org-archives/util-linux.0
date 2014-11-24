Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-ob0-f170.google.com ([209.85.214.170]:63232 "EHLO
	mail-ob0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751587AbaKXT4z (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Mon, 24 Nov 2014 14:56:55 -0500
Received: by mail-ob0-f170.google.com with SMTP id wp18so7703194obc.15
        for <util-linux@vger.kernel.org>; Mon, 24 Nov 2014 11:56:54 -0800 (PST)
Received: from [192.168.0.75] (cpe-70-123-211-202.satx.res.rr.com. [70.123.211.202])
        by mx.google.com with ESMTPSA id e8sm5982529oev.4.2014.11.24.11.56.51
        for <util-linux@vger.kernel.org>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 24 Nov 2014 11:56:52 -0800 (PST)
Message-ID: <54738D83.9010108@gmail.com>
Date: Mon, 24 Nov 2014 13:56:51 -0600
From: Bruce Dubbs <bruce.dubbs@gmail.com>
MIME-Version: 1.0
To: util-linux@vger.kernel.org
Subject: Re: LUKS partition types, redux
References: <546D0495.2030803@dasyatidae.net> <20141124113733.GC926@x2.net.home> <547343EA.6090606@ubuntu.com> <20141124154604.GA2610@x2.net.home>
In-Reply-To: <20141124154604.GA2610@x2.net.home>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Karel Zak wrote:
> On Mon, Nov 24, 2014 at 09:42:50AM -0500, Phillip Susi wrote:
>> -----BEGIN PGP SIGNED MESSAGE-----
>> Hash: SHA1
>>
>> On 11/24/2014 6:37 AM, Karel Zak wrote:
>>> The current trend is to use partition type to define for what
>>> purpose we want to use the partition (for example "this is /home")
>>> independently on partition format.
>>
>> I wouldn't call this bone headed idea of redhat's a trend.  Using
>> partition table type codes to decide to auto mount in particular parts
>> of the filesystem is such a brain damaged idea, those who thought it
>> up need beaten with a clue-by-four and its use needs to be *strongly*
>> discouraged.
>
>   well, it's designed for auto-generated fstab-less systems like
>   containers/virt images, etc. I'm not big fan of this feature, but for
>   some use cases it makes sense. (And it's systemd upstream decision.)
>
>   Anyway, use partition type for "usage" makes more sense than for "fs-type".

Since when is systemd upstream of util-linux?

   -- Bruce


