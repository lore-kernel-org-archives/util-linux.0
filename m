Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:30361 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751852AbdARNhg (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Wed, 18 Jan 2017 08:37:36 -0500
Received: from smtp.corp.redhat.com (int-mx16.intmail.prod.int.phx2.redhat.com [10.5.11.28])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 97FA5C059DB7
        for <util-linux@vger.kernel.org>; Wed, 18 Jan 2017 13:12:20 +0000 (UTC)
Received: from ws (ovpn-116-150.ams2.redhat.com [10.36.116.150])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 012666D984
        for <util-linux@vger.kernel.org>; Wed, 18 Jan 2017 13:12:19 +0000 (UTC)
Date: Wed, 18 Jan 2017 14:12:17 +0100
From: Karel Zak <kzak@redhat.com>
To: util-linux@vger.kernel.org
Subject: stable/v2.29.1
Message-ID: <20170118131217.3kv7samrkbnxmqqr@ws.net.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


The branch stable/v2.29 contains what I want to release as v2.29.1.

Any objections or suggestions? See log below.

    Karel


Andreas Henriksson (3):
      chrt: default to SCHED_RR policy
      sulogin: make getpasswd(...) return NULL on ^D
      sulogin: bail out from getpasswd(...) on timeout

Joe Hansen (1):
      po: update da.po (from translationproject.org)

Karel Zak (18):
      sfdisk: don't be silent when list non-existing device
      sfdisk: cleanup --dump error messages
      docs: nsenter(1): add missing 'see also' for --user
      hwclock: don't check for permissions
      build-sys: prefer pkg-config for ncurses
      fdisk: don't be silent when list non-existing device
      build-sys: cleanup UL_NCURSES_CHECK
      more: avoid double free() on exit
      findmnt: error on --target /non-exist
      lib/linux_version: fix stupid typo
      lscpu: add aarch64 specific names
      libsmartcols: add scols_cell_get_alignment()
      libfdisk: recount size when apply user device properties
      libfdisk: (gpt) make calculations more robust
      po: merge changes
      docs: update AUTHORS file
      docs: update v2.29.1-ReleaseNotes
      build-sys: release++ (v2.29.1)

Michael Kerrisk (25):
      docs: nsenter(1): Describe the 'file' argument used by namespace options
      docs: nsenter(1): Formatting fix
      docs: various pages: Use "system call" not "syscall"
      docs: kill(1): Fix section reference for sigqueue(3) and add to SEE ALSO
      docs: kill(1): Add more detail on use of SIGTERM vs SIGKILL
      docs: kill(1): Rework notes on thread groups
      docs: kill(1): Formatting fixes
      docs: kill(1): Wording fix
      docs: renice(1): Rework discussion of unprivileged users,
      docs: renice(1): Remove obsolete BUGS text
      docs: various pages: Format pathnames as italic (.I)
      docs: various pages: Use consistent terminology (set-user-ID and set-group-ID)
      docs: various pages: Use "ID" not "id" in man pages
      docs: various pages: Use "PID" not "pid" in man-pages
      docs: various pages: Use 'UID" and "GID", not "uid" and "gid" in man pages
      docs: kill(1): Wording fix
      docs: namei(1): SEE ALSO: add symlink(7)
      docs: taskset(1): Wording fix
      docs: last(1): SEE ALSO: add reference to wtmp(5)
      docs: last(1): Eliminate oddball formatting
      docs: lsns(8): SEE ALSO: add namespaces(7)
      docs: ionice(1): SEE ALSO: add ioprio_set(2)
      docs: mount(8): Wording fix
      docs: renice(1): Add SEE ALSO entry for sched(7)
      docs: renice(1): Add credentials(7) to SEE ALSO

Michael Kerrisk (man-pages) (12):
      Fix typo in page cross reference (capabilities(7), not, capability(7))
      Place SEE ALSO entries in order
      Correctly format page cross references
      Fix page cross references
      Fix section number in lockf() page xref
      Fix reference for scheduling discussion
      Fix formatting errors in page cross references
      Replace reference to sigvec(2) with sigaction(2)
      SEE ALSO: add cross reference to namespaces(7)
      Provide better cross references for namespace concepts
      Provide better cross references for namespace concepts
      IPC namespaces also isolate POSIX message queues

Nate Clark (4):
      disk-utils/mkfs.minix: Set ninodes after checking max
      libblkid/minix: Match minix superblock types
      libblkid/minix: Use same checks for version 3
      libblkid/minix: Sanity check superblock s_state for v 1 and 2

OGAWA Hirofumi (1):
      lsns: Fix parser for /proc/<pid>/stat which is including space in comm

Rafael Fontenelle (1):
      po: update pt_BR.po (from translationproject.org)

Ruediger Meier (3):
      build-sys: fix empty package release number
      build-sys: update package release number during development
      build-sys: don't clean *.img files

Stanislav Brabec (1):
      If mtab support is disabled, disable ro/rw mtab checks

Stéphane Aulery (1):
      po: update fr.po (from translationproject.org)



-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
