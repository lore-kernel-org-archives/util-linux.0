Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-lb0-f174.google.com ([209.85.217.174]:40105 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752324Ab2KFUBv (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Tue, 6 Nov 2012 15:01:51 -0500
Received: by mail-lb0-f174.google.com with SMTP id n3so734970lbo.19
        for <util-linux@vger.kernel.org>; Tue, 06 Nov 2012 12:01:50 -0800 (PST)
MIME-Version: 1.0
Date: Tue, 6 Nov 2012 21:01:49 +0100
Message-ID: <CANTHhvYU=J-A1VE+Ro91+-HA4MW6Dv8sGLbB16iQ3JS5JCm9sw@mail.gmail.com>
Subject: Bug in the script util
From: Daniel Narvaez <dwnarvaez@gmail.com>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Content-Type: text/plain; charset=ISO-8859-1
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Hello,

it seems like the following commit introduced a bug.

commit cdd2a8c360c70d16804ace7cc923a6c6bb7c9ca9
Author: Sami Kerola <kerolasa@iki.fi>
Date:   Wed Apr 4 19:44:04 2012 +0200

    term-utils: verify writing to streams was successful

    Signed-off-by: Sami Kerola <kerolasa@iki.fi>

Before the commit

script -e -c "echo"
echo $?
0

After the commit

script -e -c "echo"
echo $?
1

I think what happens is that we first close stderr in dooutput (as
timingfd) and then we try to close it again in atexit(close_stdout),
causing the error.

In fact redirecting timingfd to a file fixes it

script -t/tmp/a -e -c "echo"
echo $?
0

-- 
Daniel Narvaez
