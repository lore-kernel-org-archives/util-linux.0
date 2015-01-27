Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-qa0-f54.google.com ([209.85.216.54]:41429 "EHLO
	mail-qa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751337AbbA0GdT (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Tue, 27 Jan 2015 01:33:19 -0500
Received: by mail-qa0-f54.google.com with SMTP id w8so10195732qac.13
        for <util-linux@vger.kernel.org>; Mon, 26 Jan 2015 22:33:18 -0800 (PST)
MIME-Version: 1.0
Date: Mon, 26 Jan 2015 23:33:18 -0700
Message-ID: <CAJm42388wcQx0TgFEVxNXJCjKQPywO+65osLagn9_Wm=+5FB8g@mail.gmail.com>
Subject: whereis search path
From: Brandon Vincent <Brandon.Vincent@asu.edu>
To: util-linux@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Out of curiosity, it looks like the search path for whereis is hard coded.

Was the inclusion of /usr/share/info ever considered?

Brandon Vincent
