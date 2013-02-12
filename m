Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:6618 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932843Ab3BLNU4 (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 12 Feb 2013 08:20:56 -0500
Date: Tue, 12 Feb 2013 14:20:51 +0100
From: Karel Zak <kzak@redhat.com>
To: kerolasa@gmail.com
Cc: Mantas =?utf-8?Q?Mikul=C4=97nas?= <grawity@gmail.com>,
        util-linux@vger.kernel.org
Subject: Re: lslocks =?utf-8?B?4oCTICJmYWlsZQ==?= =?utf-8?Q?d?= to parse pid:
 'WRITE'"
Message-ID: <20130212132051.GB18597@x2.net.home>
References: <kf0ehe$q7h$1@ger.gmane.org>
 <CAG27Bk2dO1ztSAy47=j+nmG+v5YuMCBa0i4eorLWw2sFWRT2Pg@mail.gmail.com>
 <51197D69.6050901@gmail.com>
 <20130212111248.GG20408@x2.net.home>
 <CAG27Bk109veDrkVetXg5cRSA0TogpbhJ0PwFArRyf=pqQg0zfQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAG27Bk109veDrkVetXg5cRSA0TogpbhJ0PwFArRyf=pqQg0zfQ@mail.gmail.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Tue, Feb 12, 2013 at 11:23:49AM +0000, Sami Kerola wrote:
> I noticed another small lslocks annoyance. With narrow window 'lslocks
> | cat' is truncating lines. IMHO when writing  to pipe command should
> ignore window width.

 This is generic lib/tt.c problem. I'll fix it.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
