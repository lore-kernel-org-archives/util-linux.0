Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-iy0-f174.google.com ([209.85.210.174]:57190 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756902Ab2BGVFf (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Tue, 7 Feb 2012 16:05:35 -0500
Received: by iacb35 with SMTP id b35so10620907iac.19
        for <util-linux@vger.kernel.org>; Tue, 07 Feb 2012 13:05:35 -0800 (PST)
Subject: [PATCH 0/4] Add functions to the fsck wrapper to improve
 standalone operation.
From: Frank Mayhar <fmayhar@google.com>
To: util-linux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Date: Tue, 07 Feb 2012 13:05:33 -0800
Message-ID: <1328648733.11787.13.camel@peace.lax.corp.google.com>
Mime-Version: 1.0
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

This set of patches adds functions that help improve fsck operation in
large installations and when running in unattended or headless mode.  It
adds support for reporting rusage statistics for the individual fsck
runs, for capturing fsck output, for killing fsck runs that take too
long and for running scripts when each fsck completes.

We're currently using these functions to improve our fsck monitoring
capability and to replace some unwieldy and hard-to-maintain shell
scripts.
-- 
Frank Mayhar
fmayhar@google.com

