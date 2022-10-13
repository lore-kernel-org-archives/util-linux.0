Return-Path: <util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31CBEC433FE
	for <util-linux@archiver.kernel.org>; Thu, 13 Oct 2022 19:26:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229619AbiJMT00 (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Thu, 13 Oct 2022 15:26:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229587AbiJMT0U (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Thu, 13 Oct 2022 15:26:20 -0400
Received: from out2.migadu.com (out2.migadu.com [IPv6:2001:41d0:2:aacc::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61C3716F427
        for <util-linux@vger.kernel.org>; Thu, 13 Oct 2022 12:26:07 -0700 (PDT)
Mime-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=thomasvoss.com;
        s=key1; t=1665689165;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=Z3vgrfCQPZGvhINWUDUl/V10l9KqsiO4kbFGfilanEA=;
        b=ncmO6A7kis7f56MlU1VjBEAE4N1jTEF6L+OTgxpayJ5iFCGxiXw+sSEGHntwCOc1pqAKEs
        Hftu3Tc/uo2AYCdZ9SEcp8vL9N/0+roWfFbcqk9rhk5bzpnQm1bXcsPhO2dfACo0KYEB6b
        ea+XOP2mTKibrx/alTMBLUxe62NMzLe0yeKhEbdOkxMFfGmT8O3fXXcgSHlQl5nAAGxTMi
        +J65dpZevbcdi0vfrh1sp6zO47OzpEQ0FZNu760j6K0eI70f+AX/Di2UKQPLDVJQoCQeFB
        GsYH55g8ljih9xHI9UPz4Jq4eSn65hS0QlS/i6jluIh/4CB+ov3LtcFHLdqfIA==
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Thu, 13 Oct 2022 21:26:11 +0200
Message-Id: <CNL1J5PPBA9T.2ZR8EL0OSX1XJ@mango-os>
Subject: Proposal for new column(1) flag
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   "Thomas Voss" <mail@thomasvoss.com>
To:     <util-linux@vger.kernel.org>
X-Migadu-Flow: FLOW_OUT
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

Hello there,

I'm not sure if this is exactly the right place to ask, so forgive me if
it isn't but I was thinking of a potential new flag for the column(1)
utility and would like to get some feedback on whether or not it would
even be accepted before I try to submit a patch.

The basic issue I am aiming to fix is this:  When you have a bunch of
lines and you want to display them in a more "human friendly" manner, you
may decide to display them using columns.  This is what ls does as the
default behavior when listing files and we can in theory do this by
piping the output of whatever command we run into column.  The issue I
found however is that the way column operates is by splitting each row
into multiple columns where every column has the same width (a width
which can hold the longest input line).  ls on the other hand tries to
make each column as thin as possible, with a gap of two spaces between
each column.  This means that in many cases ls can fit the same data into
more columns than center can.

Now when listing files this is not a problem, you can always use ls
instead of center.  But I recently found myself wanting to do this with a
list of movies that I had stored in a file, and so being able to just the
following would be much more convenient, but the gaps between the columns
is just too large:

	$ column movie-list

So my proposal is to add a new flag, perhaps -g (g for gap) which allows
you to specify how wide you want the gaps between the columns to be in
spaces, and then to columnate that way.  That change would make these two
lines identical:

	$ ls *
	$ ls * | column -g 2

- Thomas
