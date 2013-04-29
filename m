Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-vb0-f50.google.com ([209.85.212.50]:58681 "EHLO
	mail-vb0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750828Ab3D2I7Q convert rfc822-to-8bit (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Mon, 29 Apr 2013 04:59:16 -0400
Received: by mail-vb0-f50.google.com with SMTP id w15so213511vbb.9
        for <util-linux@vger.kernel.org>; Mon, 29 Apr 2013 01:59:16 -0700 (PDT)
MIME-Version: 1.0
Reply-To: kerolasa@gmail.com
In-Reply-To: <517DBDB7.8090506@draigBrady.com>
References: <1367169067-23705-1-git-send-email-kerolasa@iki.fi>
	<1367169067-23705-9-git-send-email-kerolasa@iki.fi>
	<517DBDB7.8090506@draigBrady.com>
Date: Mon, 29 Apr 2013 09:59:15 +0100
Message-ID: <CAG27Bk0iSZDx=mJ_WM1sA5ins7g5zCqnTdVGLyogSZ4E9d57OA@mail.gmail.com>
Subject: Re: [PATCH 08/11] cal: allow day highlight testing
From: Sami Kerola <kerolasa@iki.fi>
To: =?ISO-8859-1?Q?P=E1draig_Brady?= <P@draigbrady.com>
Cc: util-linux <util-linux@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On 29 April 2013 01:24, Pádraig Brady <P@draigbrady.com> wrote:
> On 04/28/2013 06:11 PM, Sami Kerola wrote:
>> Requires similar trick as done with more to by pass check whether a
>> session is or isn't interactive.
>
> I wonder should we have an option or env variable to force highlighting?
> I've wanted a couple of times to pipe output like:
>   cal --color=always | ansi2html.sh

Hi Padraig,

Your proposal makes totally sense. Karel, please wait a moment (till
tomorrow) that I have a change to rewrite this change to be more
useful. I'll send new patch to the list, and update my git sometime
off-work-hour.

--
   Sami Kerola
   http://www.iki.fi/kerolasa/
