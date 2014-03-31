Return-Path: util-linux-owner@vger.kernel.org
Received: from fenja.rhi.hi.is ([130.208.165.103]:36191 "EHLO fenja.rhi.hi.is"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752932AbaCaRfu (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 31 Mar 2014 13:35:50 -0400
Received: from smtp.hi.is (smtp.hi.is [130.208.165.149])
	by fenja.rhi.hi.is (8.13.8/8.13.8) with ESMTP id s2VHO6IR028465
	for <util-linux@vger.kernel.org>; Mon, 31 Mar 2014 17:24:07 GMT
Received: from katla.rhi.hi.is (katla.rhi.hi.is [130.208.165.1])
	by smtp.hi.is (8.14.4/8.14.4) with ESMTP id s2VHO6Sm031248
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <util-linux@vger.kernel.org>; Mon, 31 Mar 2014 17:24:06 GMT
Received: from katla.rhi.hi.is (localhost [127.0.0.1])
	by katla.rhi.hi.is (8.14.4+Sun/8.14.4) with ESMTP id s2VHBILK004660
	for <util-linux@vger.kernel.org>; Mon, 31 Mar 2014 17:11:18 GMT
Received: (from bjarniig@localhost)
	by katla.rhi.hi.is (8.14.4+Sun/8.14.4/Submit) id s2VHBIsh004659
	for util-linux@vger.kernel.org; Mon, 31 Mar 2014 17:11:18 GMT
Date: Mon, 31 Mar 2014 17:11:18 +0000
From: Bjarni Ingi Gislason <bjarniig@rhi.hi.is>
To: util-linux@vger.kernel.org
Subject: [PATCH] mount.8: Some typographical and prefix corrections to the
 manual
Message-ID: <20140331171117.GA4657@rhi.hi.is>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Source: util-linux
Version: 2.24.1
File: sys-utils/mount.8
Severity: minor
Tags: patch

  Changes:

  Space at end of lines removed

  -- changed to \-\- if it means an option

  Macro BR changed to macro B if there is only one argument

  - changed to \- if it means an option

  Macro IR changed to macro I if there is only one argument

  Space put before a punctuation mark if it is a part of the only
argument to the macro IR

  A full stop (.), that begins or ends a string, protected with \&

  \- changed to - if it is to be rendered (permanently) as a hyphen in
a compound name for an option.
  People that use UTF-8 and copy-and-paste (and thus need only a
temporary display) can use the command "info", "man --ascii" or the
"man" command should have an option for these people to display both \-
and - with the code hyphen-minus (0x2D).
  This case should be solved on a meta level and not in each man page
(lowest level).


 " - " changed to " \(en " (en-dash) if it means a dash (pause,
separation)

  \, added before an italic character (italic correction)

  Macro BR changed to macro B it there is only one argument

  No line adjustment (.na) for a long line added

  \c added at the end of a line to inhibit an addition of a word space

  k (prefix for units) changed to KiB

  A comma added at end of lines when the next line continues the series
of words

  .. changed to ...

  512mb changed to 512\ MB and 176mb to 176\ MB

  ~ made bigger for troff to be better visible

  The word pickyness changed to
           pickiness

  The word binary added before mega and giga

  kibi, mebi, and gibi added after corresponding names

  - between numbers changed to \(en if it means a range

  A full stop (.) removed from the end of a name of an option

  A word space added after a comma in an enumeration

  kilobytes changed to kibibytes when the examples indicate that

  "16\ k" changed to "value=16k", etc. for clarification

  Space added to an argument for the BR macro

  Patch is in the attachment


-- 
Bjarni I. Gislason
