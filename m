Return-Path: <util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8368C433FE
	for <util-linux@archiver.kernel.org>; Mon, 17 Oct 2022 08:43:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229792AbiJQIm6 (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Mon, 17 Oct 2022 04:42:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229592AbiJQIm5 (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Mon, 17 Oct 2022 04:42:57 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA85A2CC85
        for <util-linux@vger.kernel.org>; Mon, 17 Oct 2022 01:42:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1665996172;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=GED2lrJqkbF1XTPQbS3ByxG7aJJVl2S+07q95tMCkI4=;
        b=hUKq9CDadOTzQ7I6SE6NsF2Kb6AVByFtFMbB2R8udg5tUsBnOo1T3yLPA+lUSGCq4kvIGc
        +OICFa9q02a+ErY4Jc/VW9mSJdVh+IAYVAT/aRhyxZ+/0HvR2WG2RU12YB8ODVZSrMLxRs
        /e35Wekw3BOkR0/tERXCZz59qEcT4GM=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-660-0DmawuyfOfmYEY86193T-w-1; Mon, 17 Oct 2022 04:42:50 -0400
X-MC-Unique: 0DmawuyfOfmYEY86193T-w-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C973F382F1C9;
        Mon, 17 Oct 2022 08:42:49 +0000 (UTC)
Received: from ws.net.home (ovpn-193-171.brq.redhat.com [10.40.193.171])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 4AECC404CAE0;
        Mon, 17 Oct 2022 08:42:49 +0000 (UTC)
Date:   Mon, 17 Oct 2022 10:42:47 +0200
From:   Karel Zak <kzak@redhat.com>
To:     Thomas Voss <mail@thomasvoss.com>
Cc:     util-linux@vger.kernel.org
Subject: Re: Proposal for new column(1) flag
Message-ID: <20221017084247.egoe7ljueklp5jvb@ws.net.home>
References: <CNL1J5PPBA9T.2ZR8EL0OSX1XJ@mango-os>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CNL1J5PPBA9T.2ZR8EL0OSX1XJ@mango-os>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On Thu, Oct 13, 2022 at 09:26:11PM +0200, Thomas Voss wrote:
> Hello there,
> 
> I'm not sure if this is exactly the right place to ask, so forgive me if
> it isn't but I was thinking of a potential new flag for the column(1)
> utility and would like to get some feedback on whether or not it would
> even be accepted before I try to submit a patch.
> 
> The basic issue I am aiming to fix is this:  When you have a bunch of
> lines and you want to display them in a more "human friendly" manner, you
> may decide to display them using columns.  This is what ls does as the
> default behavior when listing files and we can in theory do this by
> piping the output of whatever command we run into column.  The issue I
> found however is that the way column operates is by splitting each row
> into multiple columns where every column has the same width (a width
> which can hold the longest input line).  ls on the other hand tries to
> make each column as thin as possible, with a gap of two spaces between
> each column.  This means that in many cases ls can fit the same data into
> more columns than center can.
> 
> Now when listing files this is not a problem, you can always use ls
> instead of center.  But I recently found myself wanting to do this with a
> list of movies that I had stored in a file, and so being able to just the
> following would be much more convenient, but the gaps between the columns
> is just too large:
> 
> 	$ column movie-list
> 
> So my proposal is to add a new flag, perhaps -g (g for gap) which allows
> you to specify how wide you want the gaps between the columns to be in
> spaces, and then to columnate that way.  That change would make these two
> lines identical:
> 
> 	$ ls *
> 	$ ls * | column -g 2

I guess you want "table" mode for the column (see --table-* options).
It provides almost all features from libsmartcols. The next important
thing for your use-case is --output-separator, for example

  $ echo "AAA BBB CCC" | ./column -t --output-separator "..."
  AAA...BBB...CCC

of course you can use "   " to define space as separator, etc.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

