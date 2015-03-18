Return-Path: util-linux-owner@vger.kernel.org
Received: from out03.mta.xmission.com ([166.70.13.233]:33353 "EHLO
	out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755576AbbCRQDG convert rfc822-to-8bit (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Wed, 18 Mar 2015 12:03:06 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: Karel Zak <kzak@redhat.com>
Cc: =?utf-8?Q?J=C3=B6rg?= Thalheim <joerg@higgsboson.tk>,
        util-linux@vger.kernel.org
References: <20150318105319.2c6bab99@turingmachine>
	<20150318111313.GC28925@ws.net.home>
Date: Wed, 18 Mar 2015 10:59:16 -0500
In-Reply-To: <20150318111313.GC28925@ws.net.home> (Karel Zak's message of
	"Wed, 18 Mar 2015 12:13:13 +0100")
Message-ID: <87y4muguuj.fsf@x220.int.ebiederm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Subject: Re: [PATCH] nsenter: add support for pty
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Karel Zak <kzak@redhat.com> writes:

> On Wed, Mar 18, 2015 at 10:53:19AM +0100, Jörg Thalheim wrote:
>> If mount namespaces are used, the issued command, will not have access to the
>> tty device attached to its stdin/stdout/stderr. This patch adds an option to
>> allocate a new pseudo tty in the entered mount namespace and bridge between the
>> origin standard file descriptors and the standard file descriptors of the
>> executed command.
>
> The original nsenter(1) purpose is to have command line interface to
> setns(2) syscall. Your patch is trying to push us to something more
> complex. Not sure if we really want it. Eric, any comment?

I certainly would not want it to be the default.
After seeing the ptsname() and gpg I see what is driving it.

However playing the pty games gets us smack dab in the middle of sending
and receiving trusted input.  I don't know that I want nsenter to be on
the trusted path for entering in passwords for unlocking gpg keys.

If gpg is the driving use case I don't think it is wise to add pty
support.  All of a sudden nsenter has to become robust from side channel
attacks when you are entering in passwords and I at least have no
interest in maintaining nsenter in that way.

Eric
