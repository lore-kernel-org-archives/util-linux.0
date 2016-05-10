Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-oi0-f68.google.com ([209.85.218.68]:33031 "EHLO
	mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751318AbcEJThJ (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Tue, 10 May 2016 15:37:09 -0400
Received: by mail-oi0-f68.google.com with SMTP id t140so50675oie.0
        for <util-linux@vger.kernel.org>; Tue, 10 May 2016 12:37:08 -0700 (PDT)
MIME-Version: 1.0
Reply-To: kerolasa@gmail.com
In-Reply-To: <1462890257.1439070.603552425.7FB076BA@webmail.messagingengine.com>
References: <1462829248-6935-1-git-send-email-kerolasa@iki.fi>
	<1462829248-6935-13-git-send-email-kerolasa@iki.fi>
	<1462890257.1439070.603552425.7FB076BA@webmail.messagingengine.com>
Date: Tue, 10 May 2016 20:37:08 +0100
Message-ID: <CAG27Bk3jaepQJkYtbqjk7WRe+TsWiSkQMm_kWbOeYgtCEFNG4g@mail.gmail.com>
Subject: Re: [PATCH 12/12] write: tell when effective gid and tty path group mismatch
From: Sami Kerola <kerolasa@iki.fi>
To: Benno Schulenberg <bensberg@justemail.net>
Cc: Util-Linux <util-linux@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On 10 May 2016 at 15:24, Benno Schulenberg <bensberg@justemail.net> wrote:
>
> On Mon, May 9, 2016, at 23:27, Sami Kerola wrote:
>> +             if (getegid() != s.st_gid) {
>> +                     warnx(_("effective gid and %s group does not match"), path);
>
> For translation purposes, better make this:
>
>   "effective gid does not match group of %s"
>
> otherwise a translator might think that %s is the name of a group.
> (And the grammar of the original is incorrect.)

Thank you for review Benno, fixed in

https://github.com/kerolasa/lelux-utiliteetit/commit/8e8c57e69985a22260c30793080a9776f47081a0

-- 
Sami Kerola
http://www.iki.fi/kerolasa/
