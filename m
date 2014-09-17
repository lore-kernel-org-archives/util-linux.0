Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-pd0-f178.google.com ([209.85.192.178]:51580 "EHLO
	mail-pd0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753854AbaIQKGq (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Wed, 17 Sep 2014 06:06:46 -0400
Received: by mail-pd0-f178.google.com with SMTP id p10so1794240pdj.23
        for <util-linux@vger.kernel.org>; Wed, 17 Sep 2014 03:06:46 -0700 (PDT)
MIME-Version: 1.0
Reply-To: kerolasa@gmail.com
In-Reply-To: <1410940644.3960867.168458609.5CBEB9EB@webmail.messagingengine.com>
References: <1410002693-16540-1-git-send-email-kerolasa@iki.fi>
	<alpine.LNX.2.03.1409162118180.3712@kerolasa-home>
	<1410940644.3960867.168458609.5CBEB9EB@webmail.messagingengine.com>
Date: Wed, 17 Sep 2014 11:06:46 +0100
Message-ID: <CAG27Bk2NepknNS3BFAhtHZX54FSZLoq8Ps1rqXdEPzmxrxHp0A@mail.gmail.com>
Subject: Re: [PATCH 0/6] pull: renice changes
From: Sami Kerola <kerolasa@iki.fi>
To: Benno Schulenberg <bensberg@justemail.net>
Cc: Util-Linux <util-linux@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On 17 September 2014 08:57, Benno Schulenberg <bensberg@justemail.net> wrote:
> On Tue, Sep 16, 2014, at 22:21, Sami Kerola wrote:
>> +     fputs(_(" -u, --user <name|id>   interpret argument as username or user ID\n"), out);
>
> The argument here should be <name>|<id>.
> (Think of <> as the // markers in email.)

Thank you for review Benno,

Update is in my git repo.
https://github.com/kerolasa/lelux-utiliteetit/commit/94a6c9b3cde3741ec1f7fe10cc3cead1a42990ae

-- 
Sami Kerola
http://www.iki.fi/kerolasa/
