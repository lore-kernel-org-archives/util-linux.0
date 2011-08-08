Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-pz0-f42.google.com ([209.85.210.42]:56095 "EHLO
	mail-pz0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752485Ab1HHJQQ convert rfc822-to-8bit (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Mon, 8 Aug 2011 05:16:16 -0400
Received: by mail-pz0-f42.google.com with SMTP id 37so7995891pzk.1
        for <util-linux@vger.kernel.org>; Mon, 08 Aug 2011 02:16:16 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20110808085422.GH2204@nb.net.home>
References: <4E387230.5060002@gmail.com> <20110808085422.GH2204@nb.net.home>
From: Tom Gundersen <teg@jklm.no>
Date: Mon, 8 Aug 2011 11:15:56 +0200
Message-ID: <CAG-2HqWUpPxWcVzr9_zDE4OeO9PamsD0JuwEU1Avke49i4P22g@mail.gmail.com>
Subject: Re: umount -a
To: Karel Zak <kzak@redhat.com>
Cc: Bruce Dubbs <bruce.dubbs@gmail.com>, util-linux@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Mon, Aug 8, 2011 at 10:54 AM, Karel Zak <kzak@redhat.com> wrote:
>> Would it be reasonable to change umount -a to also omit /run if it is
>> mounted as a tmpfs?
>
>  umount -a -t notmpfs  ?

This might not work as intended if you have a tmpfs mounted on top of
a regular fs (in which case you would like to unmount them both).

I think the correct solution is to do as dracut and have a shutdown
ramfs from where you can unmount rootfs and all its mountpoints.

Cheers,

-t
