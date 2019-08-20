Return-Path: <SRS0=LZ/s=WQ=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E95CC3A589
	for <util-linux@archiver.kernel.org>; Tue, 20 Aug 2019 12:51:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD19422CF7
	for <util-linux@archiver.kernel.org>; Tue, 20 Aug 2019 12:51:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729409AbfHTMvh (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Tue, 20 Aug 2019 08:51:37 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34650 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729203AbfHTMvh (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Tue, 20 Aug 2019 08:51:37 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 99A2A3090FCB;
        Tue, 20 Aug 2019 12:51:36 +0000 (UTC)
Received: from 10.255.255.10 (ovpn-204-40.brq.redhat.com [10.40.204.40])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 9D69160605;
        Tue, 20 Aug 2019 12:51:35 +0000 (UTC)
Date:   Tue, 20 Aug 2019 14:51:32 +0200
From:   Karel Zak <kzak@redhat.com>
To:     Patrick Steinhardt <ps@pks.im>
Cc:     util-linux@vger.kernel.org,
        "Eric W. Biederman" <ebiederm@xmission.com>
Subject: Re: [PATCH] unshare: allow setting up filesystems in the mount
 namespace
Message-ID: <20190820125132.iq3w234ump62mnmb@10.255.255.10>
References: <3fcfc033d9d115649fee5f9ae05296c29033a7de.1565866421.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3fcfc033d9d115649fee5f9ae05296c29033a7de.1565866421.git.ps@pks.im>
User-Agent: NeoMutt/20180716-1584-710bcd
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.43]); Tue, 20 Aug 2019 12:51:36 +0000 (UTC)
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On Thu, Aug 15, 2019 at 12:54:45PM +0200, Patrick Steinhardt wrote:
> In order to execute commands with the least-possible privileges, it may
> be desirable to provide them with a trimmed down filesystem view.
> unshare naturally provides the ability to create mount namespaces, but
> it doesn't yet offer much in preparing these. For now, a combination of
> unshare and nsenter is required to prepare culled filesystems views,
> which is kind of unwieldy.
> 
> To remedy that, this implements a new option "--mount-fs". As
> parameters, one may specify a source filesystem, the destination where
> this filesystem shall be mounted, the type of filesystem as well as a
> set of options. unshare will then mount it using libmount right before
> performing `chroot`, `chdir` and the subsequent `execve`, which allows
> for preparing the `chroot` environment without using nsenter at all.
>
> The above is useful in several different cases, for example when one
> wants to execute the process in a read-only environment or execute it
> with a reduced view of the filesystem.

I understand your point of view, but it's a way how unshare(1) will
slowly grow from simple one-purpose tool to complex container/namespace
setup tool ;-) I do not have any strong opinion about it. Maybe your 
--mount-fs is still so basic that we can merge it into unshare(1)

Sounds like we need a discussion about it to gather more opinions :-)
(CC to Eric).

Note that the latest mount(8) has --namespace option, so you can mount
filesystems in the another namespace although the namespace does not
contain mount command and necessary libs.

And note that for systemd based distros there is systemd-nspawn which
provides many many features (include IPC, hostname, TZ, private users,
...).

> +.B # unshare
> +.B    --mount-fs=none:/tmp:tmpfs
> +.B    --mount-fs=/bin:/tmp/bin:none:bind,ro,X-mount.mkdir
> +.B    --mount-fs=/lib:/tmp/lib:none:bind,ro,X-mount.mkdir
> +.B    --mount-fs=/usr/lib:/tmp/usr/lib:none:bind,ro,X-mount.mkdir
> +.B    --root=/tmp /bin/ls /

The libmount also allows to mount all filesystem according to mount
table stored in a file, so I can imagine --fstab option ;-)

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
