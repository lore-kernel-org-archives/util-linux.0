Return-Path: util-linux-owner@vger.kernel.org
Received: from outpost1.zedat.fu-berlin.de ([130.133.4.66]:37656 "EHLO
	outpost1.zedat.fu-berlin.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755447AbcDGOAb (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Thu, 7 Apr 2016 10:00:31 -0400
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.85)
          for util-linux@vger.kernel.org with esmtps (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
          (envelope-from <marcus.hoffmann@fu-berlin.de>)
          id <1aoAU0-000x4B-Dr>; Thu, 07 Apr 2016 16:00:28 +0200
Received: from za861.pia.fu-berlin.de ([87.77.168.97] helo=[10.168.97.1])
          by inpost2.zedat.fu-berlin.de (Exim 4.85)
          for util-linux@vger.kernel.org with esmtpsa (TLSv1.2:DHE-RSA-AES128-SHA:128)
          (envelope-from <marcus.hoffmann@fu-berlin.de>)
          id <1aoAU0-001quE-6e>; Thu, 07 Apr 2016 16:00:28 +0200
Subject: unrecognized options: --without-capng
To: util-linux@vger.kernel.org
References: <20160407105400.jn66tldxy7s3rqyc@ws.net.home>
From: Marcus Hoffmann <marcus.hoffmann@fu-berlin.de>
Message-ID: <570667FB.8080104@fu-berlin.de>
Date: Thu, 7 Apr 2016 16:00:27 +0200
MIME-Version: 1.0
In-Reply-To: <20160407105400.jn66tldxy7s3rqyc@ws.net.home>
Content-Type: text/plain; charset=windows-1252
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Dear all,
in experimenting a bit with configure options I found the
--without-capng option (as reported by configure --help) giving the
following warning (and having no effect):
> configure: WARNING: unrecognized options: --without-capng

Looking into configure.ac I found the option should probably be named
--without-cap_ng (AC_ARG_WITH([cap_ng],...).

But using this the configure script dies with the following message:

> configure: error: conditional "HAVE_CAP_NG" was never defined.
> Usually this means the macro was only invoked conditionally.

--without-cap-ng produces the same result.

I tried fiddling around with the autoconf macros but got no further than
that.

Marcus
