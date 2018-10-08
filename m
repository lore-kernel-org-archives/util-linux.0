Return-Path: <SRS0=4QkE=MU=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23D65C00449
	for <util-linux@archiver.kernel.org>; Mon,  8 Oct 2018 09:10:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D43562084D
	for <util-linux@archiver.kernel.org>; Mon,  8 Oct 2018 09:09:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D43562084D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=util-linux-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726451AbeJHQUk (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Mon, 8 Oct 2018 12:20:40 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49556 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726330AbeJHQUk (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Mon, 8 Oct 2018 12:20:40 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 04B34C05000F;
        Mon,  8 Oct 2018 09:09:59 +0000 (UTC)
Received: from ws.net.home (ovpn-117-176.ams2.redhat.com [10.36.117.176])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 4640F5B0A0;
        Mon,  8 Oct 2018 09:09:58 +0000 (UTC)
Date:   Mon, 8 Oct 2018 11:09:56 +0200
From:   Karel Zak <kzak@redhat.com>
To:     L A Walsh <lkml@tlinx.org>
Cc:     util-linux@vger.kernel.org
Subject: Re: static linking working w/gnu?  (was Re: [ANNOUNCE] util-linux
 v2.33-rc1)
Message-ID: <20181008090956.k6cjvg7ztwt3bnnp@ws.net.home>
References: <20180925104701.y2gwtwe2bquynap2@ws.net.home>
 <5BB15D3A.8040507@tlinx.org>
 <20181002101454.qm5gzasb5naamnbg@ws.net.home>
 <5BBB07AA.6010403@tlinx.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5BBB07AA.6010403@tlinx.org>
User-Agent: NeoMutt/20180716-423-e60b71
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.31]); Mon, 08 Oct 2018 09:09:59 +0000 (UTC)
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On Mon, Oct 08, 2018 at 12:30:50AM -0700, L A Walsh wrote:
> 	Did you get warnings similar to the above?  The claim
> is that you should be getting similar errors, but I got the impression
> that you did not.

I get the warning, but result is still static binary. Don't ask me why
;-)

$ file ./mount.static 
./mount.static: ELF 64-bit LSB executable, x86-64, version 1 (GNU/Linux), statically linked, for GNU/Linux 3.2.0, BuildID[sha1]=b66bae970bf72346cbf6d844e0e48d5dbfd07cc2, with debug_info, not stripped

The problem is the way how glibc uses stuff around NSS. In this case
glibc needs runtime modules, for more details see:

  https://sourceware.org/glibc/wiki/FAQ#Even_statically_linked_programs_need_some_shared_libraries_which_is_not_acceptable_for_me.__What_can_I_do.3F

on Fedora, the mount.static is static, but I guess glibc internally
uses some ldopen() when need NSS or iconv stuff.

It seems the issue is only getpwnam_r() which is necessary only when
mount(8) translates gid=<name> to gid=<number>. It's rarely used
mount(8) feature.

> One person claimed it to be a bug in the Gnu tools & lib, while
> others claim its designed that way, so not a bug...*sigh*.

I think you do not want to try resolve this issues in the utils.

It's all about libc design. If glibc does not well for you, then 
you need something else. For example uclibc, or glibc without NSS,
etc.

Now you know why we have projects like dracut for initramfs. It's
better to use standard libs and utils than try to build parallel
universe to boot or for rescue disks.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
