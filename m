Return-Path: <SRS0=/ORA=7O=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93B2BC433DF
	for <util-linux@archiver.kernel.org>; Mon,  1 Jun 2020 07:53:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6399620734
	for <util-linux@archiver.kernel.org>; Mon,  1 Jun 2020 07:53:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LJxTn8X2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726265AbgFAHxf (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Mon, 1 Jun 2020 03:53:35 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:25319 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725999AbgFAHxe (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Mon, 1 Jun 2020 03:53:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1590998014;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=wPXNLpJ0sZZ7Z/P4nG8c8VAID1vS3tYXPAuC4j7yojI=;
        b=LJxTn8X2wgYa+AceLSYYD7tyzkg3hT+kBSnWpjKIR5Kv69Gp3yRGvyKONUAwpIj9TnOWJJ
        QFzqHdTSj0jMGZoNW7YX1ecWctX6riSEkodopFjfsjtILnCYYWpH6iuEsPDwRcb3Ttt6nZ
        6wRwdykyQ4zsvbk6HAGkIgfvYhQIm7c=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-102-G-ivek-EOLyEryK5zmkRqw-1; Mon, 01 Jun 2020 03:53:30 -0400
X-MC-Unique: G-ivek-EOLyEryK5zmkRqw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 238CF107ACCA;
        Mon,  1 Jun 2020 07:53:29 +0000 (UTC)
Received: from ws.net.home (unknown [10.40.194.133])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 259DDD01E1;
        Mon,  1 Jun 2020 07:53:27 +0000 (UTC)
Date:   Mon, 1 Jun 2020 09:53:25 +0200
From:   Karel Zak <kzak@redhat.com>
To:     Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Cc:     kerolasa@gmail.com, util-linux <util-linux@vger.kernel.org>
Subject: Re: [PATCH] dmesg: add --follow-new
Message-ID: <20200601075325.ufmficzg5u57ocek@ws.net.home>
References: <159084767331.127122.9117317049390963928.stgit@buzz>
 <CAG27Bk3Tvybn0ToQdBNu9O-=Ap70+APKqLCCT-4cTxx-vFiFqw@mail.gmail.com>
 <1d1e123b-d107-78c2-e76c-c5be3dcdf89e@yandex-team.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1d1e123b-d107-78c2-e76c-c5be3dcdf89e@yandex-team.ru>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On Sun, May 31, 2020 at 03:18:47PM +0300, Konstantin Khlebnikov wrote:
> On 31/05/2020 14.49, Sami Kerola wrote:
> > On Sat, 30 May 2020 at 15:08, Konstantin Khlebnikov
> > <khlebnikov@yandex-team.ru> wrote:
> > > Option --follow-new (-W) works the same as --follow (-w) but initially
> > > seeks to the end of kernel ring buffer, so it prints only new messages.
> > > Useful for capturing kernel messages during actions without past log.

IMHO good idea.

> > I wonder if it would be more useful to add '-n, --lines=[+]NUM' that
> > would be similar
> > to tail(1) option and argument. The --follow-new with an option that
> > lists NUM last
> > messages would be --lines=0

It does not seem use-friendly ;-) I guess type "-W" is pretty 
straightforward.
	
> > That said should --since and --until options similar to journalctl(1)
> > be considered
> > as well?

 --since '1 hour ago' would be nice, but I have doubts it's will so
 easy to implement due to crazy timestamps in the log.

> Implementation is also non-trivial - currently dmesg reads and prints
> messages from /dev/kmsg in a loop. It doesn't know how many lines left.
> /dev/kmsg doesn't support lseek with non-zero offset, only SET/DATA/END.

 Yes.

    Karel


-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

