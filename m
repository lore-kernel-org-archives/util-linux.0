Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-we0-f174.google.com ([74.125.82.174]:57030 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753549Ab2JHHIq (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Mon, 8 Oct 2012 03:08:46 -0400
Received: by mail-we0-f174.google.com with SMTP id t9so2368146wey.19
        for <util-linux@vger.kernel.org>; Mon, 08 Oct 2012 00:08:44 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 00/14] various: clean ups and fixes
Date: Mon,  8 Oct 2012 08:08:06 +0100
Message-Id: <1349680100-18120-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Here comes half random bunch of patches, where most of them should make
you yawn.

I guess the most noticable is ddate removal, which will outrage
disordians.  Perhaps getting loads of 'signed-off-by' lines from
distribution packagers & active contributors will make it clear that UL
project is tired to keep such pointless garbage in source.

[PATCH 01/14] ddate: remove from util-linux
[PATCH 02/14] column: add --output-separator option
[PATCH 03/14] docs: fix column.1 groff syntax error
[PATCH 04/14] pg: refactor argument handing
[PATCH 05/14] pg: use libc error printing facilities
[PATCH 06/14] pg: add const qualifiers where suitable
[PATCH 07/14] pg: add noreturn function attributes
[PATCH 08/14] pg: use unistd.h STDOUT_FILENO
[PATCH 09/14] pg: do not turn off warnigns artificially
[PATCH 10/14] pg: fix coding style
[PATCH 11/14] more: fix coding style
[PATCH 12/14] more: align void in functions with prototypes, and
[PATCH 13/14] more: remove few memory leaks
[PATCH 14/14] swapon: remove loop declaration [smatch scan]

-- 
   Sami Kerola
   http://www.iki.fi/kerolasa/
