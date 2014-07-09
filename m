Return-Path: util-linux-owner@vger.kernel.org
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:55946 "EHLO
	out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751268AbaGINeq (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Wed, 9 Jul 2014 09:34:46 -0400
Message-Id: <1404912883.3362.139744757.5A3CCE0A@webmail.messagingengine.com>
From: Benno Schulenberg <bensberg@justemail.net>
To: Rafael Ferreira <rafael.f.f1@gmail.com>
Cc: "Util-Linux" <util-linux@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: bug report in lslogins strings
Date: Wed, 09 Jul 2014 15:34:43 +0200
In-Reply-To: <CALLTvwd4SPLWosR9ko1EXoP7pyTigof_0bQmhjUzLiR6EZDi_w@mail.gmail.com>
References: <CALLTvwd4SPLWosR9ko1EXoP7pyTigof_0bQmhjUzLiR6EZDi_w@mail.gmail.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


Hello Rafael,

On Tue, Jul 8, 2014, at 16:58, Rafael Ferreira wrote:
> While translating util-linux, I found one typo (unsupported with two 's'):
> 
> In file login-utils/lslogins.c, line 332:
> "unssupported time type"

Thanks.  For this and other typos I will submit a patch as soon as 2.25
is out (to not unnecessarily invalidate translations).

> Also, while not a bug, I think the below strings could be changed in
> order to have more consistence. Maybe line 1160 could be "users' last
> failed logins" ? See:
> 
> In file login-utils/lslogins.c, line 1160:
> " -f, --failed             display data about the last users' failed logins\n"

Well-spotted.  The patch will fix that too.

Benno

-- 
http://www.fastmail.fm - A no graphics, no pop-ups email service

