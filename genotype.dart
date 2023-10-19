class Genotype {
  final String _genotype;

  Genotype(String genotype) : _genotype = genotype {
    if (!isValidGenotype(genotype)) {
      throw Exception('Genótipo inválido: $genotype');
    }
  }

  String get bloodType {
    if (_genotype == 'AA' || _genotype == 'Ai') {
      return 'A';
    } else if (_genotype == 'BB' || _genotype == 'Bi') {
      return 'B';
    } else if (_genotype == 'AB') {
      return 'AB';
    } else if (_genotype == 'ii') {
      return 'O';
    }
    return 'Desconhecido';
  }

  List<String> get alleles {
    final Set<String> alleleSet = Set<String>.from(_genotype.split(''));

    return alleleSet.toList()..sort();
  }

  List<String> get agglutinogens {
    final Set<String> agglutinogenSet = Set<String>.from(_genotype.split(''))
      ..remove('i');

    return agglutinogenSet.toList()..sort();
  }

  List<String> get agglutinins {
    final Set<String> agglutininsSet = {'A', 'B'};
    final List<String> agglutinogens = _genotype.split('')..sort();
    final List<String> result = agglutininsSet
        .difference(Set<String>.from(agglutinogens))
        .toList()
      ..sort();
    return result;
  }

  List<String> offsprings(Genotype other) {
    final Set<String> offspringSet = <String>{};

    final List<String> alleles1 = _genotype.split('')..sort();
    final List<String> alleles2 = other._genotype.split('')..sort();

    final alleleMap = {'A': 1, 'B': 2, 'i': 3};

    for (final allele1 in alleles1) {
      for (final allele2 in alleles2) {
        final offspring =
            combineAlleles(alleleMap[allele1]!, alleleMap[allele2]!);
        if (isValidGenotype(offspring)) {
          offspringSet.add(offspring);
        }
      }
    }

    return offspringSet.toList()..sort();
  }

  String combineAlleles(int allele1, int allele2) {
    final alleleList = [allele1, allele2]..sort();
    final reverseMap = {1: 'A', 2: 'B', 3: 'i'};
    return reverseMap[alleleList[0]]! + reverseMap[alleleList[1]]!;
  }

  bool compatible(Genotype other) {
    final selfBloodType = bloodType;
    final otherBloodType = other.bloodType;

    if (selfBloodType == 'O') {
      return true;
    } else if (otherBloodType == 'AB') {
      return true;
    } else if (selfBloodType == 'A' &&
        (otherBloodType == 'A' || otherBloodType == 'AB')) {
      return true;
    } else if (selfBloodType == 'B' &&
        (otherBloodType == 'B' || otherBloodType == 'AB')) {
      return true;
    }

    return false;
  }

  bool isValidGenotype(String genotype) {
    final validGenotypes = ['AA', 'Ai', 'BB', 'Bi', 'AB', 'ii'];
    return validGenotypes.contains(genotype);
  }

  @override
  String toString() {
    return _genotype;
  }
}
