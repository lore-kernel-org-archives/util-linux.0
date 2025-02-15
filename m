Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2E121AAA1B
	for <util-linux@vger.kernel.org>; Sat, 15 Feb 2025 16:19:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739636370; cv=none; b=Je/oFkgFGSDkN49f97VLe3dkp7EuNCZmMNxevB8QZ58AwGTivy81YKS00752rPa46FtqZaCQkp9nWYhK0GRyPxrFBDi3SBoK2wawg8IOhGWt4SZlvwDSVc1ocOzsQ+HzQkVgkKI26LHKAlPj81pWkMix7YXa/F3ZzT0A0dM4kaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739636370; c=relaxed/simple;
	bh=1TihERzXExdRMXleSvajHjSgM7bsGlLQR01KUrf+gmM=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=V7z+kE9YoHigVg9n9I89vIblMTgLemTDnvENmoNMLvgnqtwlRUVvhbz2moF9ow9u8tco8EY4wRpnK5B108z3ZCTWxACC1sv4DuLBJnCrHPAn9bkW4LLskuwA+bg4Z3c9QBMrP8t4wM10wULwvlzb+QX/vChtk3cki2a3Nckn/p4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=telfort.nl; spf=pass smtp.mailfrom=telfort.nl; dkim=pass (1024-bit key) header.d=telfort.nl header.i=@telfort.nl header.b=QUOs1Ul1; arc=none smtp.client-ip=195.121.94.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=telfort.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=telfort.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=telfort.nl header.i=@telfort.nl header.b="QUOs1Ul1"
X-KPN-MessageId: 9de0ba61-ebb8-11ef-9fb2-005056abad63
Received: from smtp.kpnmail.nl (unknown [10.31.155.40])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id 9de0ba61-ebb8-11ef-9fb2-005056abad63;
	Sat, 15 Feb 2025 17:19:22 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=telfort.nl; s=telfort01;
	h=mime-version:message-id:date:subject:to:from;
	bh=vDKhsmTJVsAuF7Eiih9EycZYluzgMC6lrMeEy1reoQU=;
	b=QUOs1Ul1Gb51WAaXKKVfCadpgk7YfY30m4OdPnHmYqde+XyODC0IcyIb5283QKakS3kMMRUemmDrM
	 SLFPKtrLVLbeZXG1K0JbjpGiDJgk0e1Np0pr5JLEqZiyF8sSdI41d3mhZHlHHiQtoT6PhIcTf3HX6q
	 0jLI4ISiiBDJBYPY=
X-KPN-MID: 33|rWM6ukQrpfSP74aG7M6f/FFsS2SvRF55A7JV4oPABLR0r2yUa7GSBwU5B+6UVOr
 XCU86f5GgGCAOJTAgGQGaQJOs/yoXrYe1jbYwl9XELoo=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|0amKkKJ2Iu9MpTw7UTBQzceeyB/Zz5fcH2gHo4AykeU+9RrQDfA35sw+ldxIkum
 1ubrubKb6LB3zpeXYoeRDUQ==
Received: from localhost (77-163-176-192.fixed.kpn.net [77.163.176.192])
	by smtp.kpnmail.nl (Halon) with ESMTPSA
	id 9bfc05de-ebb8-11ef-be91-005056ab7584;
	Sat, 15 Feb 2025 17:19:19 +0100 (CET)
From: Benno Schulenberg <bensberg@telfort.nl>
To: util-linux@vger.kernel.org
Subject: [PATCH 03/10] setterm: mark literal values in the man page in bold
Date: Sat, 15 Feb 2025 17:18:36 +0100
Message-ID: <20250215161843.12053-3-bensberg@telfort.nl>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250215161843.12053-1-bensberg@telfort.nl>
References: <20250215161843.12053-1-bensberg@telfort.nl>
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Also, add a few commas for readability, tweak some wordings,
and add a "T" that was lost six years ago in commit bc6439ba32.

Signed-off-by: Benno Schulenberg <bensberg@telfort.nl>
---
 term-utils/setterm.1.adoc | 52 ++++++++++++++++++++++-----------------
 1 file changed, 29 insertions(+), 23 deletions(-)

diff --git a/term-utils/setterm.1.adoc b/term-utils/setterm.1.adoc
index 3fdee3283..1e6c2f5e1 100644
--- a/term-utils/setterm.1.adoc
+++ b/term-utils/setterm.1.adoc
@@ -23,7 +23,13 @@ setterm - set terminal attributes
 
 == DESCRIPTION
 
-*setterm* writes to standard output a character string that will invoke the specified terminal capabilities. Where possible _terminfo_ is consulted to find the string to use. Some options however (marked "virtual consoles only" below) do not correspond to a *terminfo*(5) capability. In this case, if the terminal type is "con" or "linux" the string that invokes the specified capabilities on the PC Minix virtual console driver is output. Options that are not implemented by the terminal are ignored.
+*setterm* writes to standard output a character string that will invoke the
+specified terminal capabilities. Where possible, _terminfo_ is consulted to
+find the string to use. Some options (marked "virtual consoles only" below)
+do not correspond to a *terminfo*(5) capability. In these cases, if the
+terminal type is "con" or "linux", the string that invokes the specified
+capability on the PC Minix virtual console is output. Options that are
+not implemented by the terminal are ignored.
 
 == OPTIONS
 
@@ -37,16 +43,16 @@ The various color options may be set independently, at least on virtual consoles
 
 The optional arguments are recommended with '=' (equals sign) and not space between the option and the argument. For example --option=argument. *setterm* can interpret the next non-option argument as an optional argument too.
 
-*--appcursorkeys* on|off::
+*--appcursorkeys* **on**|**off**::
 Sets Cursor Key Application Mode on or off. When on, ESC O A, ESC O B, etc. will be sent for the cursor keys instead of ESC [ A, ESC [ B, etc. See the _vi and Cursor-Keys_ section of the _Text-Terminal-HOWTO_ for how this can cause problems for *vi* users. Virtual consoles only.
 
 *--append* _console_number_::
 Like *--dump*, but appends to the snapshot file instead of overwriting it. Only works if no *--dump* options are given.
 
-*--background* __8-color__|default::
+*--background* __8-color__|**default**::
 Sets the background text color.
 
-*--blank*[**=**0-60|force|poke]::
+*--blank*[**=0**-**60**|**force**|**poke**]::
 Sets the interval of inactivity, in minutes, after which the screen will be automatically blanked (using APM if available). Without an argument, it gets the blank status (returns which vt was blanked, or zero for an unblanked vt). Virtual consoles only.
 +
 The *force* argument keeps the screen blank even if a key is pressed.
@@ -56,22 +62,22 @@ The *poke* argument unblanks the screen.
 *--bfreq*[**=**_number_]::
 Sets the bell frequency in Hertz. Without an argument, it defaults to *0*. Virtual consoles only.
 
-*--blength*[**=**0-2000]::
+*--blength*[**=0**-**2000**]::
 Sets the bell duration in milliseconds. Without an argument, it defaults to *0*. Virtual consoles only.
 
-*--blink* on|off::
+*--blink* **on**|**off**::
 Turns blink mode on or off. Except on a virtual console, *--blink off* turns off all attributes (bold, half-brightness, blink, reverse).
 
-*--bold* on|off::
-urns bold (extra bright) mode on or off. Except on a virtual console, *--bold off* turns off all attributes (bold, half-brightness, blink, reverse).
+*--bold* **on**|**off**::
+Turns bold (extra bright) mode on or off. Except on a virtual console, *--bold off* turns off all attributes (bold, half-brightness, blink, reverse).
 
-*--clear*[**=**all|rest]::
+*--clear*[**=all**|**rest**]::
 Without an argument or with the argument *all*, the entire screen is cleared and the cursor is set to the home position, just like *clear*(1) does. With the argument *rest*, the screen is cleared from the current cursor position to the end.
 
 *--clrtabs*[**=**_tab1 tab2 tab3_ ...]::
-Clears tab stops from the given horizontal cursor positions, in the range *1-160*. Without arguments, it clears all tab stops. Virtual consoles only.
+Clears tab stops from the given horizontal cursor positions, in the range *1*-*160*. Without arguments, it clears all tab stops. Virtual consoles only.
 
-*--cursor* on|off::
+*--cursor* **on**|**off**::
 Turns the terminal's cursor on or off.
 
 *--default*::
@@ -83,10 +89,10 @@ Writes a snapshot of the virtual console with the given number to the file speci
 *--file* _filename_::
 Sets the snapshot file name for any *--dump* or *--append* options on the same command line. If this option is not present, the default is _screen.dump_ in the current directory. A path name that exceeds the system maximum will be truncated, see *PATH_MAX* from _linux/limits.h_ for the value.
 
-*--foreground* __8-color__|default::
+*--foreground* __8-color__|**default**::
 Sets the foreground text color.
 
-*--half-bright* on|off::
+*--half-bright* **on**|**off**::
 Turns dim (half-brightness) mode on or off. Except on a virtual console, *--half-bright off* turns off all attributes (bold, half-brightness, blink, reverse).
 
 *--hbcolor* _16-color_::
@@ -95,21 +101,21 @@ Sets the color for half-bright characters.
 *--initialize*::
 Displays the terminal initialization string, which typically sets the terminal's rendering options, and other attributes to the default values.
 
-*--inversescreen* on|off::
+*--inversescreen* **on**|**off**::
 Swaps foreground and background colors for the whole screen.
 
-*--linewrap* on|off::
+*--linewrap* **on**|**off**::
 Makes the terminal continue on a new line when a line is full.
 
-*--msg* on|off::
+*--msg* **on**|**off**::
 Enables or disables the sending of kernel *printk*() messages to the console. Virtual consoles only.
 
-*--msglevel* 0-8::
+*--msglevel* **0**-**8**::
 Sets the console logging level for kernel *printk()* messages. All messages strictly more important than this will be printed, so a logging level of *0* has the same effect as *--msg on* and a logging level of *8* will print all kernel messages. *klogd*(8) may be a more convenient interface to the logging of kernel messages.
 +
 Virtual consoles only.
 
-*--powerdown*[**=**0-60]::
+*--powerdown*[**=0**-**60**]::
 Sets the VESA powerdown interval in minutes. Without an argument, it defaults to *0* (disable powerdown). If the console is blanked or the monitor is in suspend mode, then the monitor will go into vsync suspend mode or powerdown mode respectively after this period of time has elapsed.
 
 *--powersave* _mode_::
@@ -124,10 +130,10 @@ Puts the monitor into VESA powerdown mode.
 *off*;;
 Turns the monitor's powersaving features off.
 
-*--regtabs*[**=**1-160]::
+*--regtabs*[**=1**-**160**]::
 Clears all tab stops, then sets a regular tab stop pattern, with one tab every specified number of positions. Without an argument, it defaults to *8*. Virtual consoles only.
 
-*--repeat* on|off::
+*--repeat* **on**|**off**::
 Turns keyboard repeat on or off. Virtual consoles only.
 
 *--reset*::
@@ -136,14 +142,14 @@ Displays the terminal reset string, which typically resets the terminal to its p
 *--resize*::
 Reset terminal size by assessing maximum row and column. This is useful when actual geometry and kernel terminal driver are not in sync. Most notable use case is with serial consoles, that do not use *ioctl*(2) but just byte streams and breaks.
 
-*--reverse* on|off::
+*--reverse* **on**|**off**::
 Turns reverse video mode on or off. Except on a virtual console, *--reverse off* turns off all attributes (bold, half-brightness, blink, reverse).
 
 *--store*::
 Stores the terminal's current rendering options (foreground and background colors) as the values to be used at reset-to-default. Virtual consoles only.
 
 *--tabs*[**=**_tab1 tab2 tab3_ ...]::
-Sets tab stops at the given horizontal cursor positions, in the range *1-160*. Without arguments, it shows the current tab stop settings.
+Sets tab stops at the given horizontal cursor positions, in the range *1*-*160*. Without arguments, it shows the current tab stop settings.
 
 *--term* _terminal_name_::
 Overrides the *TERM* environment variable.
@@ -151,7 +157,7 @@ Overrides the *TERM* environment variable.
 *--ulcolor* _16-color_::
 Sets the color for underlined characters. Virtual consoles only.
 
-*--underline* on|off::
+*--underline* **on**|**off**::
 Turns underline mode on or off.
 
 include::man-common/help-version.adoc[]
-- 
2.48.1

