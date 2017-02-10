Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.17.20]:51905 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751060AbdBJVED (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Fri, 10 Feb 2017 16:04:03 -0500
Subject: [PATCH 1/3] gnulib: add source for gnulib parse-datetime mod
To: Karel Zak <kzak@redhat.com>
References: <bbd64daa-5431-8c7d-580b-3382a33edccd@gmx.com>
Cc: util-linux@vger.kernel.org
From: J William Piggott <elseifthen@gmx.com>
Message-ID: <db4182d4-29bf-f354-3a3d-60a8cdac7ada@gmx.com>
Date: Fri, 10 Feb 2017 16:03:16 -0500
MIME-Version: 1.0
In-Reply-To: <bbd64daa-5431-8c7d-580b-3382a33edccd@gmx.com>
Content-Type: text/plain; charset=windows-1252
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


Install gnulib's parse-datetime module (and its dependencies) for use
with hwclock.

Note: the full path to the gnulib source must be used with the gnulib-tool.

Command used:
/path/to/gnulib/src/gnulib-tool --libtool --no-vc-files --source-base=gllib --m4-base=glm4 --doc-base=gllib/gldoc --tests-base=gltests --import parse-datetime

Signed-off-by: J William Piggott <elseifthen@gmx.com>
---

Not reviewable and to large to post.

