.PHONY: builddir csvfile check probe

DATADIR := meet-data
BUILDDIR := build

PLFILE := openpowerlifting.csv
PLFILEJS := openpowerlifting.js
MEETFILE := meets.csv
MEETFILEJS := meets.js

all: csvfile sqlite web

builddir:
	mkdir -p '${BUILDDIR}'

# Cram all the data into a single, huge CSV file.
csvfile: builddir
	scripts/compile "${BUILDDIR}" "${DATADIR}" "lifter-data"
	scripts/csv-bodyweight "${BUILDDIR}/${PLFILE}"
	scripts/csv-wilks "${BUILDDIR}/${PLFILE}"

sqlite: csvfile
	scripts/prepare-for-sqlite
	scripts/compile-sqlite

web: csvfile
	$(MAKE) -C web

# Make sure that all the fields in the CSV files are in expected formats.
check:
	tests/check-entries-csv
	tests/check-meet-csv
	tests/check-sex-consistency
	tests/check-lifter-data
	tests/check-name-corrections lifter-data/name-corrections.dat

# List of probes for federations that should be fully up-to-date,
# or at least are quick to read and not filled with noise.
# Data showing up here should be immediately actionable.
probe-quick:
	${DATADIR}/aau/aau-probe --quick || true
	${DATADIR}/apa/apa-probe || true
	${DATADIR}/apc/apc-probe --quick || true
	${DATADIR}/apf/apf-probe --quick || true
	${DATADIR}/bb/bb-probe || true
	${DATADIR}/capo/capo-probe --quick || true
	${DATADIR}/commonwealthpf/commonwealthpf-probe || true
	${DATADIR}/cpf/cpf-probe --quick || true
	${DATADIR}/cpl/cpl-probe --quick || true
	${DATADIR}/gbpf/gbpf-probe --quick || true
	${DATADIR}/herc/herc-probe || true
	${DATADIR}/ipa/ipa-probe --quick || true
	${DATADIR}/irishpf/irishpf-probe || true
	${DATADIR}/nasa/nasa-probe --quick || true
	${DATADIR}/nipf/nipf-probe || true
	${DATADIR}/oceaniapf/oceaniapf-probe --quick || true
	${DATADIR}/pa/pa-probe --quick || true
	${DATADIR}/rps/rps-probe || true
	${DATADIR}/rupc/rupc-probe || true
	${DATADIR}/scottishpl/scottishpl-probe --quick || true
	${DATADIR}/spf/spf-probe || true
	${DATADIR}/spf-archive/spf-archive-probe || true
	${DATADIR}/upa/upa-probe || true
	${DATADIR}/usapl/usapl-probe || true
	${DATADIR}/usapl-archive/usapl-archive-probe --quick || true
	${DATADIR}/uspa/uspa-probe || true
	${DATADIR}/xpc/xpc-probe || true

# List of all probes.
probe:
	${DATADIR}/aau/aau-probe || true
	${DATADIR}/apa/apa-probe || true
	${DATADIR}/apc/apc-probe || true
	${DATADIR}/apf/apf-probe || true
	${DATADIR}/bb/bb-probe || true
	${DATADIR}/capo/capo-probe || true
	${DATADIR}/commonwealthpf/commonwealthpf-probe || true
	${DATADIR}/cpf/cpf-probe || true
	${DATADIR}/cpl/cpl-probe || true
	${DATADIR}/epf/epf-probe || true
	${DATADIR}/fesupo/fesupo-probe || true
	${DATADIR}/fpo/fpo-probe || true
	${DATADIR}/gbpf/gbpf-probe || true
	${DATADIR}/herc/herc-probe || true
	${DATADIR}/ipa/ipa-probe || true
	${DATADIR}/ipf/ipf-probe || true
	${DATADIR}/irishpf/irishpf-probe || true
	${DATADIR}/napf/napf-probe || true
	${DATADIR}/nasa/nasa-probe || true
	${DATADIR}/nipf/nipf-probe || true
	${DATADIR}/nsf/nsf-probe || true
	${DATADIR}/oceaniapf/oceaniapf-probe || true
	${DATADIR}/pa/pa-probe || true
	${DATADIR}/raw/raw-probe || true
	${DATADIR}/rps/rps-probe || true
	${DATADIR}/rupc/rupc-probe || true
	${DATADIR}/scottishpl/scottishpl-probe || true
	${DATADIR}/spf/spf-probe || true
	${DATADIR}/spf-archive/spf-archive-probe || true
	${DATADIR}/thspa/thspa-probe || true
	${DATADIR}/upa/upa-probe || true
	${DATADIR}/usapl/usapl-probe || true
	${DATADIR}/usapl-archive/usapl-archive-probe || true
	${DATADIR}/uspa/uspa-probe || true
	${DATADIR}/wrpf/wrpf-probe || true
	${DATADIR}/xpc/xpc-probe || true

clean:
	rm -rf '${BUILDDIR}'
	rm -rf 'scripts/__pycache__'
	rm -rf 'tests/__pycache__'
	rm -rf '${DATADIR}/apf/__pycache__'
	rm -rf '${DATADIR}/cpu/__pycache__'
	rm -rf '${DATADIR}/ipf/__pycache__'
	rm -rf '${DATADIR}/nasa/__pycache__'
	rm -rf '${DATADIR}/nipf/__pycache__'
	rm -rf '${DATADIR}/nsf/__pycache__'
	rm -rf '${DATADIR}/pa/__pycache__'
	rm -rf '${DATADIR}/rps/__pycache__'
	rm -rf '${DATADIR}/spf/__pycache__'
	rm -rf '${DATADIR}/thspa/__pycache__'
	rm -rf '${DATADIR}/usapl/__pycache__'
	rm -rf '${DATADIR}/wrpf/__pycache__'
	$(MAKE) -C server clean
	$(MAKE) -C web clean
