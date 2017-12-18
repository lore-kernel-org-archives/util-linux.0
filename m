Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.17.21]:60435 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754229AbdLRAru (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Sun, 17 Dec 2017 19:47:50 -0500
Subject: Fixes for commit 3c49b23
To: Karel Zak <kzak@redhat.com>,
        util-linux <util-linux@vger.kernel.org>
From: J William Piggott <elseifthen@gmx.com>
Message-ID: <72856395-656c-b67d-1b28-f121e3f05b11@gmx.com>
Date: Sun, 17 Dec 2017 19:47:49 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


So, there are some issues with commit 3c49b23

* it contains multi-byte characters (which is what drew me to reading it).
* it truncates one very important piece of the formula: ". . . (mod 7)."
* it explains the values for 'e', but there is no 'e' in the code.
* it doesn't include a row resolving 'e' in the table, so it is not
   obvious what it relates to in the code.
* without citing it as an external reference, the comment language is confusing.

Anyway, I took a shot at trying to write a comment:

	 /*
	 * The magic constants in the reform[] array are, in a simplified
	 * sense, the remaining days after slicing into one week periods the total
	 * days from the beginning of the year to the target month. That is,
	 * weeks + reform[] days gets us to the target month. The exception is,
	 * that for the months past February 'DOY - 1' must be used.
	 *
	 *   DoY (Day of Year): total days to the target month
	 *
	 *   Month            1  2  3  4   5   6   7   8   9  10  11  12
	 *   DoY              0 31 59 90 120 151 181 212 243 273 304 334
	 *   DoY % 7          0  3
	 *   DoY - 1 % 7      - --  2  5   0   3   5   1   4   6   2   4
	 *       reform[] = { 0, 3, 2, 5,  0,  3,  5,  1,  4,  6,  2,  4 };
	 *
	 *  Note: these calculations are for non leap years.
	 */

I cannot send this as a patch, because my system mangles the multi-byte
characters so it won't apply cleanly.

On a somewhat related note, multi-byte characters are also making it
into the commit log; it's not a big deal I suppose, but it sure makes a
mess for systems that don't support them.




