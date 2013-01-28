Return-Path: util-linux-owner@vger.kernel.org
Received: from mx4-phx2.redhat.com ([209.132.183.25]:41242 "EHLO
	mx4-phx2.redhat.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754552Ab3A1WBc (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Mon, 28 Jan 2013 17:01:32 -0500
Date: Mon, 28 Jan 2013 17:01:30 -0500 (EST)
From: Miloslav Trmac <mitr@redhat.com>
To: Cody Maloney <cmaloney@theoreticalchaos.com>
Cc: util-linux@vger.kernel.org
Message-ID: <1221077942.16839972.1359410490623.JavaMail.root@redhat.com>
In-Reply-To: <CA+K3q6qDgdrXxbesZ-373xMYgA=oyjMnaejJWNtBaYj8HfR04w@mail.gmail.com>
Subject: Re: [PATCH v2 3/4] chsh: Add libuser support
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Hello,
----- Original Message -----
> On Mon, Jan 14, 2013 at 10:16 AM, Miloslav Trmac <mitr@redhat.com>
> wrote:
> > (On second thought, if the program is setuid, the setuid execution
> > mechanism doesn't change supplementary groups, so perhaps the call
> > isn't strictly necessary; Still, initializing the groups makes the
> > environment more deterministic.  And as long as initgroups() is
> > called, it should be called in a way that works.)
> 
> I'm fine with/would prefer dropping the initgroups entirely (That the
> initgroups man page, at least on my system, specifically talks about
> reading them from /etc/group, never mentioning nss worries me). If
> that's okay with you, otherwise I can move it to the beginning of
> dropping privileges.

Sorry about the late reply; after discussing it with colleagues, it seems that dropping the initgroups() is completely safe here.
    Mirek
