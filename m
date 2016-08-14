Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-oi0-f45.google.com ([209.85.218.45]:35024 "EHLO
	mail-oi0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753302AbcHNMbx (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 14 Aug 2016 08:31:53 -0400
Received: by mail-oi0-f45.google.com with SMTP id 4so33950926oih.2
        for <util-linux@vger.kernel.org>; Sun, 14 Aug 2016 05:31:52 -0700 (PDT)
MIME-Version: 1.0
Reply-To: kerolasa@gmail.com
In-Reply-To: <1471171172.420914.694810761.436EE6D9@webmail.messagingengine.com>
References: <20160814072406.2991-1-kerolasa@iki.fi> <20160814072406.2991-2-kerolasa@iki.fi>
 <1471171172.420914.694810761.436EE6D9@webmail.messagingengine.com>
From: Sami Kerola <kerolasa@iki.fi>
Date: Sun, 14 Aug 2016 13:31:52 +0100
Message-ID: <CAG27Bk3xCttFO4=s49P2fW8vM7OciTUhG-y7cg05kewdy0rwEQ@mail.gmail.com>
Subject: Re: [PATCH 2/3] kill: remove pid command-name to option alias
To: Benno Schulenberg <bensberg@justemail.net>
Cc: Util-Linux <util-linux@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On 14 August 2016 at 11:39, Benno Schulenberg <bensberg@justemail.net> wrote:
> On Sun, Aug 14, 2016, at 09:24, Sami Kerola wrote:
>> Removal was promised to happen at March 2014 and the time has to get rid of
>> this unexpected feature.
>
> s/at March/in March/
> s/2014/2016/
> s/time has/time has come/

Thanks Benno fixed in 'misc' branch.

https://github.com/kerolasa/lelux-utiliteetit/commit/0be3ad70ad85cce75be6fffb87fa81e62bd4b105

-- 
Sami Kerola
http://www.iki.fi/kerolasa/
