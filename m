Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-qe0-f48.google.com ([209.85.128.48]:48936 "EHLO
	mail-qe0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751521Ab3HZMrc (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Mon, 26 Aug 2013 08:47:32 -0400
Received: by mail-qe0-f48.google.com with SMTP id 1so1699637qec.35
        for <util-linux@vger.kernel.org>; Mon, 26 Aug 2013 05:47:32 -0700 (PDT)
Date: Mon, 26 Aug 2013 08:47:30 -0400
From: Dave Reisner <d@falconindy.com>
To: util-linux@vger.kernel.org
Subject: building pylibmount when python -> python3
Message-ID: <20130826124730.GN699@rampage>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

This came up in IRC and I thought it might be a good idea to mention it
to the list. With pylibmount recently being merged into git, some folks
might have trouble building from HEAD if their /usr/bin/python points to
a version python>=3.0. While the end goal (after discussion with Karel)
seems to be that we should be able to build this for both python2 and
python3, you can work around the build failure for now by simply passing
--with-python=/usr/bin/python2 (or --without-python if you don't care
for the new module).

Cheers,
Dave
